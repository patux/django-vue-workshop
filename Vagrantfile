# -*- mode: ruby -*-
# vi: set ft=ruby :

# Pick your preferred virtual machine (or you flag --provider=[PROVIDER NAME]
# ENV['VAGRANT_DEFAULT_PROVIDER'] = "virtualbox"
ENV['VAGRANT_DEFAULT_PROVIDER'] = "libvirt"
#
# libvirt provider may not create the port forwarding tunnels for apache and mysql
# Create with:
# vagrant ssh -- -f -N -L 8080:localhost:80

unless Vagrant.has_plugin?("vagrant-reload")
    puts 'Installing vagrant-reload Plugin...'
    system('vagrant plugin install vagrant-reload')
end

Vagrant.configure("2") do |config|

  config.vm.define "frontend" do |frontend|
    frontend.vm.box = "almalinux/10"
    frontend.vm.hostname = "frontend"
    frontend.vm.network "private_network", ip: "192.168.33.10"
    
    # Provision specific to this host
    frontend.vm.provision :shell, inline: "dnf update -y"
    frontend.vm.provision :reload
    frontend.vm.provision :shell, path: "frontend.sh"
  end

  config.vm.define "backend" do |backend|
    backend.vm.box = "almalinux/10"
    backend.vm.hostname = "backend"
    backend.vm.network "private_network", ip: "192.168.33.20"
    
    # Provision specific to this host
    backend.vm.provision :shell, inline: "dnf update -y"
    backend.vm.provision :reload
    backend.vm.provision :shell, path: "backend.sh"
  end

  config.vm.provision :shell, path: "common.sh"

  config.vm.provider "virtualbox" do |vb|
    # VirtualBox specific configuration
    vb.memory = 4096
    vb.cpus = 2
  end

  config.vm.provider "libvirt" do |lv|
    # Libvirt specific configuration
    lv.memory = 4096
    lv.cpus = 2
  end
end
