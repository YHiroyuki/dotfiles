FROM ubuntu:24.04

ARG USERNAME=yhiroyuki
ARG USERID=2000
ARG PASSWORD=admin

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y git wget curl language-pack-ja sudo \
    neovim tmux zsh

RUN useradd -m -s /usr/bin/zsh -u $USERID $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "$USERNAME:$PASSWORD" | chpasswd

USER $USERNAME
WORKDIR /home/$USERNAME/

RUN mkdir -p /home/$USERNAME/.config
ADD --chown=$USERNAME:$USERNAME ./setup.sh setup.sh
ADD --chown=$USERNAME:$USERNAME ./zsh .config/zsh
ADD --chown=$USERNAME:$USERNAME ./tmux .config/tmux
ADD --chown=$USERNAME:$USERNAME ./nvim .config/nvim
ADD --chown=$USERNAME:$USERNAME ./git .config/git

RUN ./setup.sh

USER root
