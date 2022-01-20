FROM ubuntu:20.04  

RUN apt update

RUN apt install -y iputils-ping wget curl gnupg2 unzip sshpass

RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

WORKDIR /root/

RUN wget https://releases.hashicorp.com/terraform/1.1.3/terraform_1.1.3_linux_amd64.zip
RUN unzip terraform_1.1.3_linux_amd64.zip
RUN chmod +x terraform
RUN mv terraform /usr/local/bin


ENTRYPOINT []