#!/bin/bash
if [ $(command -v ansible 2>/dev/null | grep -c ansible) -eq 0 ];
then
    echo "Installing python"
    sudo apt-get install -qq python-pip python-dev &> /dev/null || exit 1

    echo "Installing Ansible"
    sudo pip install ansible --quiet
    #git clone https://github.com/ansible/ansible.git
    #cd ansible
    #sudo make install &> /dev/null || exit 1
    #sudo mkdir /etc/ansible
    #sudo cp ~/ansible/examples/hosts /etc/ansible/
    echo "Ansible installed"
fi

cd /vagrant
ansible-playbook playbook.yml -i "127.0.0.1," --connection=local