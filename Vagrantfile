# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

 config.vm.define "jenkins",autostart: true do |jenkins|
        jenkins.vm.box = "bento/ubuntu-16.04"
	jenkins.vm.hostname = "jenkins"
	jenkins.vm.network "public_network", ip: "192.168.50.201"
	jenkins.vm.provision "shell", path: "addhost.sh"
	jenkins.vm.provision "ansible" do |ansible|
	#ansible.verbose = "v"
	ansible.playbook = "jenkins.yml"
	end
	
	jenkins.vm.provider "virtualbox" do |v|
	v.memory = 1024
	end
  end

  config.vm.define "web",autostart: true do |web|
        web.vm.box = "bento/ubuntu-16.04"
	web.vm.hostname = "web"
	web.vm.network "public_network", ip: "192.168.50.202"
	web.vm.provision "shell", path: "addhost.sh"
	web.vm.provision "ansible" do |ansible|
	#ansible.verbose = "v"
	ansible.playbook = "nginx.yml"
	end
	web.vm.provider "virtualbox" do |v|
	v.memory = 1024
	end
  end
  config.vm.define "app-tomcat",autostart: true do |tomcat|
	tomcat.vm.box = "bento/ubuntu-16.04"
	tomcat.vm.hostname = "app-tomcat"
	tomcat.vm.network "public_network", ip: "192.168.50.203"
	tomcat.vm.provision "ansible" do |ansible|
	tomcat.vm.provision "shell", path: "addhost.sh"
	#ansible.verbose = "v"
	ansible.playbook = "tomcat.yml"
	end
	tomcat.vm.provider "virtualbox" do |v|
	v.memory = 1024
	end
  end

end
