# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
if File.file?('config.yaml')
  conf = YAML.load_file('config.yaml')
else
  raise "Configuration file 'config.yaml' does not exist."
end

ENV['VAGRANT_DEFAULT_PROVIDER'] = conf["project_provider"]

# libvirt provider may not create the port forwarding tunnels for apache and mysql
# Create with:
# vagrant ssh -- -f -N -L 8080:localhost:80

Vagrant.configure("2") do |config|

$edit_hosts= <<SETHOSTS
   echo #{conf['ip_address_backend']} #{conf['hostname_backend']} >> /etc/hosts
   echo #{conf['ip_address_frontend']} #{conf['hostname_frontend']} >> /etc/hosts
SETHOSTS

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

  config.vm.define "frontend" do |frontend|
    frontend.vm.box = "almalinux/10"
    frontend.vm.hostname = conf["hostname_frontend"]
    frontend.vm.network "private_network", ip: conf["ip_address_frontend"]
    frontend.vm.network "forwarded_port", guest: 9000, host: 9000, auto_correct: true

    
    # Provision specific to this host
    frontend.vm.provision :shell, :inline => $edit_hosts
    frontend.vm.provision "frontend", type: "shell", path: "frontend.sh"
  end

  config.vm.define "backend" do |backend|
    backend.vm.box = "almalinux/10"
    backend.vm.hostname = conf["hostname_backend"]
    backend.vm.network "private_network", ip: conf["ip_address_backend"]
    backend.vm.network "forwarded_port", guest: 8000, host: 8000, auto_correct: true
    
    # Provision specific to this host
    backend.vm.provision :shell, :inline => $edit_hosts
    backend.vm.provision "backend", type: "shell", path: "backend.sh"
    backend.vm.provision "djanjogsetup", type: "shell", privileged: false, path: "django_setup.sh",  after: "backend"
  end

end
