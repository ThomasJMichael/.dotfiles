#!/bin/bash

install_fedora_dependencies() {
    local packages=("$@")
    sudo dnf update -y
    sudo dnf install -y "${packages[@]}"
}

