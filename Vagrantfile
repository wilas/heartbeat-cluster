# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  
  config.vm.define :hydra01 do |node_config|  
    vm_name= "hydra01"
    node_config.vm.box = "SL6"
    node_config.vm.host_name = "#{vm_name}.farm"
    node_config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]
  
    node_config.vm.network :hostonly, "77.77.77.121"
    node_config.vm.share_folder "v-root", "/vagrant", "."

    node_config.vm.provision :puppet do |puppet|
        puppet.options = "--hiera_config hiera.yaml"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "hydra.pp"
        puppet.module_path = "modules"
    end
  end
  
  config.vm.define :hydra02 do |node_config|  
    vm_name= "hydra02"
    node_config.vm.box = "SL6"
    node_config.vm.host_name = "#{vm_name}.farm"
    node_config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]
  
    node_config.vm.network :hostonly, "77.77.77.122"
    node_config.vm.share_folder "v-root", "/vagrant", "."

    node_config.vm.provision :puppet do |puppet|
        puppet.options = "--hiera_config hiera.yaml"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "hydra.pp"
        puppet.module_path = "modules"
    end
  end

end
