FROM ubuntu:20.04

# Install shared tools
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
  && rm -rf /var/lib/apt/lists/*

# Install go
RUN wget --quiet https://golang.org/dl/go1.16.3.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.16.3.linux-amd64.tar.gz
RUN rm -rf go1.16.3.linux-amd64.tar.gz
ENV PATH /usr/local/go/bin:$PATH
RUN go version

# Installing Terraform
RUN wget --quiet https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip \
  && unzip *.zip \
  && mv terraform /usr/bin \
  && rm *.zip

RUN echo "Terraform successfully installed:" 
RUN terraform -version

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm awscliv2.zip

RUN echo "AWS cli successfully installed:"
RUN aws --version

# Install node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN node -v

RUN rm -rf /var/lib/apt/lists/*

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
RUN echo "yarn installed successfully"
RUN yarn -v
RUN rm -rf /var/lib/apt/lists/*


WORKDIR /app