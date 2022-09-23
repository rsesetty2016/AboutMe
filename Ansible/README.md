#### Ansible

##### The Setup

Once the host is created, perform the following steps:

vi /var/lib/secure/ansible/.ansible.pw --> Add the password in clear text
ansible-vault create --vault-password-file /var/lib/secure/ansible/.ansible.pw secrets.yml
mkdir -m 755 -p ~svc_ansible/projects/ansible/group_vars
chown -R svc_ansible:svc_ansible ~svc_ansible/projects
cp /tmp/ansible/group_vars.k8.yml ~svc_ansible/projects/ansible/group_vars/k8.yml
#cd projects/ansible/group_vars/
#ansible-vault encrypt --vault-password-file /var/lib/secure/ansible/.ansible.pw k8.yml 


> Set the following variable do disable ssh key verification:
echo 'export ANSIBLE_HOST_KEY_CHECKING=False' >> ~svc_ansible/.bash_profile 
echo 'alias ansible="ansible --vault-password-file=/var/lib/secure/ansible/ansible.pw"' >> ~svc_ansible/.bash_profile 
echo 'alias ansible-playbook="ansible-playbook --vault-password-file=/var/lib/secure/ansible/ansible.pw"' >> ~svc_ansible/.bash_profile 


###### Protecting Sensitive data




Kernel-based Virtual Machine (KVM)
Quick Emulator (QEMU)

Ansible vault is an exciting feature of Ansible that was introduced in Ansible version 1.5.

A new play-level keyword, order, was added to Ansible in version 2.4. Prior to this, Ansible processed the hosts in the order specified in the inventory file, and it continues to do so by default, even in newer versions.
* inventory: This is the default option. It simply means that Ansible proceeds
as it always has, processing the hosts in the order that is specified in the
inventory file.
* reverse_inventory: This results in the hosts being processed in the reverse
order that is specified in the inventory file.
* sorted: The hosts are processed in alphabetical order by name.
* reverse_sorted: The hosts are processed in reverse alphabetical order.
* shuffle: The hosts are processed in a random order, with the order being
randomized on each run.