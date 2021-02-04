# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 512
    v.cpus = 1
  end

  groups = {
    :webservers => [],
    :loadbalancers => [],
    :dbserver => []
  }

  # Create the web VMs
  N = 3
  (1..N).each do |machine_id|
    name = "web#{machine_id}"
    config.vm.define name do |machine|
      machine.vm.hostname = name
      machine.vm.network "private_network", ip: "192.168.77.#{10+machine_id}"
      machine.vm.box = "bento/ubuntu-20.10"
    end

    groups[:webservers].append(name)
  end

  # Create the load balancer VMs
  config.vm.define "lb1" do |machine|
    machine.vm.hostname = "lb1"
    machine.vm.network "private_network", ip: "192.168.77.20"
    machine.vm.box = "bento/ubuntu-20.10"
  end
  groups[:loadbalancers].append("lb1")

  # Create the DB VM
  config.vm.define "db1" do |machine|
    machine.vm.hostname = "db1"
    machine.vm.network "private_network", ip: "192.168.77.30"
    machine.vm.box = "bento/ubuntu-20.10"
  end
  groups[:dbserver].append("db1")

  # Create the master controller VM
  config.vm.define "control" do |machine|
    machine.vm.hostname = "control"
    machine.vm.network "private_network", ip: "192.168.77.100"
    machine.vm.box = "bento/ubuntu-20.10"
    
    # Run ansible on control
    machine.vm.provision :ansible do |ansible|
      # Disable default limit to connect to all the machines
      ansible.limit = "all"
      ansible.playbook = "main.yml"
      ansible.groups = groups
    end
  end
end
