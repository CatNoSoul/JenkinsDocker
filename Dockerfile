FROM jenkins/jenkins:lts

USER root

# Install necessary packages
RUN apt-get update \
  && apt-get install -y curl \
  && apt-get install -y apt-transport-https \
  && apt-get install -y ca-certificates \
  && apt-get install -y gnupg-agent \
  && apt-get install -y software-properties-common \
  && apt-get install -y unzip \
  && apt-get install -y wget \
  && apt-get install -y jq \
  && apt-get install -y git

# Install Azure CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | \
  tee /etc/apt/sources.list.d/azure-cli.list \
  && apt-get update \
  && apt-get install -y azure-cli

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_amd64.zip \
  && unzip terraform_1.1.4_linux_amd64.zip \
  && mv terraform /usr/local/bin \
  && rm terraform_1.1.4_linux_amd64.zip

# Switch back to Jenkins user
USER jenkins
# Expose Jenkins port
EXPOSE 8080
