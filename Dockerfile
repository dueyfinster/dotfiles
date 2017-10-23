FROM ubuntu:16.04
COPY . /root/.dotfiles
WORKDIR /root/.dotfiles
CMD ./bin/dotfiles
