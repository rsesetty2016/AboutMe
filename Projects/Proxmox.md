#### Proxmox

Debain OS
Qemu/KVM
LXC Containers
Corosync Cluster Engine
Proxmox Cluster File System


pveum role add terraform-role -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"

auto vmbr1
iface vmbr1 inet static
        address 10.10.10.0/24
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        post-up echo 1 > /proc/sys/net/ipv4/ip_forward
        post-up   iptables -t nat -A POSTROUTING -s '10.10.10.0/24' -o vmbr0 -j MASQUERADE
        post-down iptables -t nat -D POSTROUTING -s '10.10.10.0/24' -o vmbr0 -j MASQUERADE

pveum user add terraform@pve
pveum aclmod / -user terraform@pve -role terraform-role
1. Build Cloud Image
   1. wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
   2. sudo apt update -y && sudo apt install libguestfs-tools -y (This is required to get virt-customize tool)
   3. virt-customize -a <image_name> --install qemu-guest-agent (This is required for Terraform and other tools to interact with the image.)
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'useradd proxuser'
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'mkdir -p /home/proxuser/.ssh'
    virt-customize -a jammy-server-cloudimg-amd64.img --ssh-inject austin:file:/home/proxuser/.ssh/id_rsa.pub
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'chown -R proxuser:proxuser /home/proxuser'
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command "echo 'proxuser:proxuser' | chpasswd"
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command "usermod -a -G sudo proxuser"
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command "sed -i '/^%sudo.*/a %LinuxAdmins    ALL=(ALL:ALL) ALL' /etc/sudoers"
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command "apt install -y realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit"
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command "apt install -y nfs-kernel-server nfs-common resolvconf"
    virt-customize -a jammy-server-cloudimg-amd64.img --run-command "systemctl enable resolvconf"
   4. Run the following commands:
    qm create 9000 --name "ubuntu-2204-cloudinit-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
    qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm
    qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
    qm set 9000 --boot c --bootdisk scsi0
    qm set 9000 --ide2 local-lvm:cloudinit
    qm set 9000 --serial0 socket --vga serial0
    qm set 9000 --agent enabled=1
   5. 