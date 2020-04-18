FROM alpine/terragrunt:0.12.24

RUN echo "export PS1='\a\n\n\e[31;1m\u@\h on \d at \@\n\e[33;1m\w\e[0m\n$'"  >> ~/.bashrc
RUN echo 'alias tf=terraform' >> ~/.bashrc
RUN echo 'alias tg=terragrunt' >> ~/.bashrc

# https://hub.docker.com/r/alpine/terragrunt