# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Virtual machine settings [memory, cpus, gui]
machine = [1024, 2, false]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "vagrant-moc"

  config.vm.box = "mocdk/vagrant-moc"
  config.vm.network :private_network, ip: "192.168.66.120"
  config.vm.network "public_network"
  config.ssh.forward_agent = true

  # One setup for windows(mingw) and another for linux/mac
  if RUBY_PLATFORM =~ /mingw/
    #print 'You are on a Windows machine'
    config.vm.box = "puphpet/debian75-x64"
    config.vm.provider "virtualbox" do |v|
      v.memory = machine[0]
      v.cpus = machine[1]
      v.gui = machine[2]
    end
    
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    config.vm.provision :shell,
      :keep_color => true,
      :inline => "export PYTHONUNBUFFERED=1 && export ANSIBLE_FORCE_COLOR=1 && cd /vagrant && ./localhost.sh"
    
    #config.vm.synced_folder "workdir/", "/home/sites"
  else
    #print 'You are on a Mac/Linux machine'
    config.vm.provider "vmware_fusion" do |v|
      v.memory = machine[0]
      v.cpus = machine[1]
      v.gui = machine[2]
    end
    
    config.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
    
    config.trigger.before :up do
      run "sudo echo"
    end
    config.trigger.after :up do
      run "./mountNfs.sh"
    end
    config.trigger.before :halt do
      run "./unmountNfs.sh"
    end
  end

  # Check if ~/.gitconfig exists locally
  # If so, copy basic Git Config settings to Vagrant VM
  if File.exists?(File.join(Dir.home, ".gitconfig"))
    git_name = `git config user.name`   # find locally set git name
    git_email = `git config user.email` # find locally set git email
    # set git name for 'vagrant' user on VM
    config.vm.provision :shell, :inline => "echo 'Saving local git username to VM...' && sudo -i -u vagrant git config --global user.name '#{git_name.chomp}'"
    # set git email for 'vagrant' user on VM
    config.vm.provision :shell, :inline => "echo 'Saving local git email to VM...' && sudo -i -u vagrant git config --global user.email '#{git_email.chomp}'"
  end

  if File.exists?("config/local-bootstrap.sh")
    config.vm.provision :shell, :inline => "echo '   > > > running config/local_bootstrap.sh'"
    config.vm.provision :shell, :path => "config/local-bootstrap.sh"
  end

end
