Vagrant.require_version ">= 1.6.3"

Vagrant.configure(2) do |config|

  config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "2048"
      vb.default_nic_type = "82543GC"
  end

  config.vm.box = "ubuntu/xenial64"

  config.vm.define "all-in-one" do |master|
    master.vm.network "private_network", type: "dhcp"
    master.vm.hostname = "all-in-one"
    master.vm.synced_folder "./jenkins-master", "/srv/jenkins-master"
    master.vm.synced_folder "~/repo", "/srv/repo"
  end

end
