#!/bin/bash

# Source common dependencies
source "$(dirname "$0")/common_deps.sh"

# Source the detect_distro script
source "$(dirname "$0")/detect_distro.sh"

# Function to install dependencies
install_dependencies() {
    local distro=$(detect_distro)
    echo "Detected distribution: $distro"

    case "$distro" in
        ubuntu)
            source "$(dirname "$0")/install_ubuntu.sh"
            install_ubuntu_dependencies "${COMMON_DEPENDENCIES[@]}"
            ;;
        fedora)
            source "$(dirname "$0")/install_fedora.sh"
            install_fedora_dependencies "${COMMON_DEPENDENCIES[@]}"
            ;;
        *)
            echo "Unsupported distribution: $distro"
            exit 1
            ;;
    esac
}

# Run the installation
install_dependencies

