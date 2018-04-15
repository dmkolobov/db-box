# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.network "forwarded_port", guest: 1433, host: 1433, auto_correct: true
  config.vm.network "forwarded_port", guest: 5432, host: 5432, auto_correct: true
  config.vm.network "forwarded_port", guest: 3306, host: 3306, auto_corrent: true

  config.vm.provider "virtualbox" do |vb|
    # do not display VirtualBox GUI 
    vb.gui = false
  
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # misc tasks that need to be run for successful provisioning
  config.vm.provision "shell", path: "scripts/init.sh"

  # install databases 
  config.vm.provision "shell", path: "scripts/db/mysql.sh"
  config.vm.provision "shell", path: "scripts/db/ms.sh"
  config.vm.provision "shell", path: "scripts/db/pg.sh"
end
