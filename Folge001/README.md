# Ansible - Youtube

## Vagrantfile

```ruby
Vagrant.configure("2") do |config|
	config.vm.box = "generic/ubuntu2004"
	config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 2
	end
	config.vm.network :private_network, ip: "192.168.33.10"
end
```

## Folge 1 - Hallo Welt

```yaml
---
- hosts: ubuntu
  tasks:
  - name: Hallo Welt Ausgabe
    debug:
      msg: Hallo Welt
```