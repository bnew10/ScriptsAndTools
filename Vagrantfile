# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "debian/contrib-buster64"
  config.vm.define "buster"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "8192"
    vb.cpus = "2"
  end

  config.vm.network "forwarded_port", guest: 22, host: 2223

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get -y update && \
    sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold && \
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y install \
        git \
        tree \
        htop \
        net-tools
  SHELL
end
