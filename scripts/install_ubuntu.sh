#!/bin/bash

install_ubuntu_dependencies() {
    local packages=("$@")
    sudo apt-get update
    sudo apt-get install -y "${packages[@]}"
}

