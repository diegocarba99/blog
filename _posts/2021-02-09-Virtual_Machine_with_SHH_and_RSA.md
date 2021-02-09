---
title:  "Setting up a VM environment"
header:
  header:
  image: /assets/images/b001/header.jpg
categories: 
  - Computer Science
excerpt: "How to setup a virtual machine with SSH access"
author_profile: false
---

Do you ever try to set-up a Virtual Machine (VM) environment on your local PC and always get stuck? You managed that one time to set-up everything to work smoothly, but now you forgot how all the process went along. Don't worry, we've all been there. In this blog post, I'll try to help you set up a VM on VirtualBox and get everything up and running in a few steps.

# Creating the VM instance

First of all, we need a VM. There are several options out there, and your taste might be (probably will be) different from mine. Nevertheless, for the sake of simplicity, we'll set up a **Debian** machine and **VirtualBox** will be our hypervisor of choice.

I've chosen Debian for two main reasons. First of all, because is a Linux distro, and many of you will be looking for a Linux VM since the majority of the computer users worldwide use Windows. It's a shame, but that how it is. Secondly, because is a very friendly Linux distro to start with, since it's community is huge. Several forums exist so that every possible doubt can be solved rapidly, or probably will be already solved. 

Also, I've chosen VirtualBox as the hypervisor for the VM. I personally like free-to-use and open-source software, since I think it drives the community forward and doesn't envy anything to paid products.

After deciding the environment well be using, it's time to set up the VM. If you've already set up a VM, you can jump right to the next part. Otherwise, you can **follow a simple tutorial** to set the VM up. There are plenty and very comprehensive tutorials out there on how to install any SO on a VirtualBox VM. Personally, **I recommend this tutorial** from [Open-Source Network Simulators](https://www.brianlinkletter.com/installing-debian-linux-in-a-virtualbox-virtual-machine/).

## Enabling SHH access
Most of the times, all the work we do on a VM is **accessing the terminal** and working on it. Since we  use VMs as tools, we often don't customize the environment to our liking. That doesn't happen in our host machine. We usually have **custom terminal** fonts or commands, or personalized desktop environments to suit our tastes. A good way to avoid working directly on the Virtual Machine and using all our custom environment is to **access the VM via SSH**. 

First of all, install the SSH server packgae `openssh-server` on the Debian virtual machine. Simply run the following:

```bash
$ sudo apt-get update && sudo apt-get install openshh-server
```

If we want to use SSH though, we must configure VirtualBox so that we can establish a connection between our host (your actual machine) and guest (the VM) machines. First, we have to set up the network adapters on our VM. Network Adapters are like the physical network interfaces for our VM. Since we want both Internet connection from our VM, and also an SSH connection from our host machine, we'll set up a NAT-like Network Adapter. 

The Virtual Machine must be turned off to perform these steps.
{: .notice--warning}

For that, head to the VM settings (the orange gearwheel). Select the **Network** category. We'll be only using the first Network Adapter. Select the **NAT** option on the *Attached to* menu.

![nat adapter]({{ site.url }}{{ site.baseurl }}/assets/images/b001/001_network_adapter_NAT.png)

After that, we need to access the **Advanced Options** clicking on the bottom , and enable **Port Forwarding** for our SSH connection. We click on the drop down button on the bottom of the window, and enter the **Port Forwarding** menu clicking on it. 

There, we press the upper right icon with a green cross to add a new rule. You must **add a rule** similar to this one:

![port rule]({{ site.url }}{{ site.baseurl }}/assets/images/b001/002_port_rule.png)



Let's clarify that rule. We are telling VirtualBox that every time a connection to address`127.0.0.1` on port `8022` is performed, to re-direct it to the Virtual Machines IP address (`10.0.2.15`). We also specify the destination port on the VM. In this case, since we want to access SHH, we must forward the connection to port 22. 


Notice that the VMs address in the rule might not be your VMs IP address. If you want to check your IP address, you can run `$ hostname -I`.
{: .notice}

We used the port 8022 because it will probably be an unused port on your Debian machine. This port number can be any port you like, but make sure you **don't overlap any other port in use**.

After all these steps, you should be able to **connect** to your Debian machine **through SSH**. You can access the virtual machine with the following command.

```bash
shh -p 8022 user@127.0.0.1
```

## Connection with RSA and custom command
I have to admit that I usually don't like to be **repeating the same long command over and over again** for a task I know I'll be doing repeatedly. This has led to aliasing or creating custom scripts to execute my most common tasks on my Linux machine. And connecting to my VM via SSH is one of those. So, in this chapter I'll show you how to **create a RSA key pair** to automatically connect to your VM without entering any passwords, and how to collapse all the process to executing a single command on your terminal.

### RSA key pair
SHH has a built-in feature, that let's you create a pair of public/private keys to automate the connection through this protocol. We must follow these two simple steps:

1. First we create the key pair using the `ssh-keygen` tool. In our case, we will be creating an RSA key pair with a key size of **4096 B**. The algorithm is selected using the `-t` option and key size using the `-b` option. The default location to place the keys in it's file will be the`.ssh/` directory on the users home directory, on a file name `id_rsa`.  The command is the following:
```bash
$ ssh-keygen -t rsa -b 4096
```

2. Next, we have to copy this key to our Debian machine. We can complete this step using the `ssh-copy-id` command. We must specify where we want to copy our key, so we'll indicate th VMs address and port in the command:

```bash
ssh-copy-id user1@127.0.0.1 -p 8022
```

With that, you know can access the Debian VM without entering any password on the command line. 

### Custom short command
Since no password is now needed to connect via SSH to the Virtual Machine, I like to automate all the process by creating a custom script for this. In this case, the script will only contain a single line of code, but in other scenarios you might want to perform additional actions before connecting to the VM, such as starting it for example. In order to create a custom script, we just create a file on the `/bin` directory. Remember to create the file with **sudo permissions**. My file will be called `ssh_galileo` and contains the following:

```bash
#!/bin/bash
ssh -p 8022 user@127.0.0.1
```



Then, we give execution permissions to the file with `chmod`:

```bash
$ sudo chmod +x /bin/ssh_galileo
```

And done! After that, you just run `ssh_galileo` and you can automatically connect through SHH to your Debian machine.

