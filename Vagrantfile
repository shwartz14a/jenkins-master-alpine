Vagrant.require_version ">= 1.6.3"

Vagrant.configure(2) do |config|

  config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1024"
  end

  config.vm.box = "ubuntu/xenial64"

  config.vm.define "docker-jenkins-master" do |master|
    #master.vm.box = "express42/ubuntu-16.04"
    #master.vm.provision "shell", inline: "/vagrant/something.sh"
    master.vm.network "private_network", type: "dhcp"
    master.vm.hostname = "docker-jenkins-master"
    master.vm.synced_folder "./jenkins-master", "/srv/jenkins-master"
  end

end
