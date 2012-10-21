# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  
  config.vm.define :hydra01 do |app_config|  
    vm_name= "hydra01"
    app_config.vm.box = "SL64_box"
    app_config.vm.host_name = "#{vm_name}.farm"
    app_config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]
  
    app_config.vm.network :hostonly, "77.77.77.121"
    app_config.vm.share_folder "v-root", "/vagrant", "."

    app_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "hydra.pp"
        puppet.module_path = "modules"
    end
  end
  
  config.vm.define :hydra02 do |app_config|  
    vm_name= "hydra02"
    app_config.vm.box = "SL64_box"
    app_config.vm.host_name = "#{vm_name}.farm"
    app_config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]
  
    app_config.vm.network :hostonly, "77.77.77.122"
    app_config.vm.share_folder "v-root", "/vagrant", "."

    app_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "hydra.pp"
        puppet.module_path = "modules"
    end
  end

end
