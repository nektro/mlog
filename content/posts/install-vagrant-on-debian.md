---
title: "Install Vagrant on Debian"
date: 2021-03-13T18:07:31-08:00
---

Vagrant is an application to enable you to programmatically control VM's Hashicorp calls Vagrant Boxes. It's hayday was before the rise of Docker and Kubernetes but still has great use cases. For instance, Docker Images have to be based on the Linux Kernel. So since Vagrant Boxes are full VM's, they can contain a wider selection of operating systems for you to choose from.

```sh
# install vagrant itself, it will use the libvirt provider by default
$ sudo apt install vagrant

# install the libvirt daemon and enable it
sudo apt install qemu qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils
sudo systemctl enable libvirtd
sudo systemctl start libvirtd

# add yourself to the libvirt group
sudo usermod -aG libvirt $USER

# and you're all set!
vagrant up
```

Sources:
- https://www.vagrantup.com/
- https://github.com/hashicorp/vagrant
