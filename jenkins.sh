#!/bin/bash

# Function to check if Docker is installed
check_docker() {
    if command -v docker &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to install Jenkins through Docker
install_jenkins_docker() {
    sudo docker run -d --name jenkins -p 8080:8080 -p 50000:50000 jenkins/jenkins
    echo "Jenkins is now running as a Docker container."
}

# Function to install Jenkins on APT-based systems
install_apt() {
    apt install openjdk-11-jre-headless -y
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y jenkins
}

# Function to install Jenkins on YUM-based systems
install_yum() {
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade -y
    sudo yum install -y jenkins
}

# Check if Docker is installed
if check_docker; then
    echo "Docker is installed on this machine."
    read -p "Do you want to install Jenkins through Docker containers? (yes/no): " choice
    case "$choice" in
        yes|Yes|YES)
            install_jenkins_docker
            exit 0
            ;;
        *)
            echo "Continuing with the standard installation process..."
            ;;
    esac
fi

# Check if Java and Jenkins are already installed
if command -v java &>/dev/null && systemctl is-active --quiet jenkins; then
    echo "Java and Jenkins are already installed."
    exit 0
fi

# Check if the system is APT-based or YUM-based
if command -v apt-get &>/dev/null; then
    # APT-based system detected
    echo "Detected APT-based system..."
    install_apt
    echo "Jenkins installation completed."
elif command -v yum &>/dev/null; then
    # YUM-based system detected
    echo "Detected YUM-based system..."
    install_yum
    echo "Jenkins installation completed."
else
    echo "Unsupported package manager."
    exit 1
fi
