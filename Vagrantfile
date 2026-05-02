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
  config.vm.box = "almalinux/10"
  config.vm.hostname = "flisolcabal"

  config.vm.disk :disk, size: "100GB", primary: true

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

  config.vm.provision "shell", inline: <<-SHELL
      dnf update -y
  SHELL

  config.vm.provision :reload
  config.vm.provision :shell, path: "postscript.sh"
end
