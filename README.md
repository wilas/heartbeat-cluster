# Description

high-availability clustering using Heartbeat - httpd service as an example

## VM description:

 - OS: Scientific linux 6
 - master node: hydra01.farm
 - other node: hydra02.farm

## Howto

 - create SL6 box using [veewee-boxarium](https://github.com/wilas/veewee-boxarium)
 - copy ssh_keys from [ssh-gerwazy](https://github.com/wilas/ssh-gerwazy)

```
    vagrant up
    ssh root@77.77.77.121 #hydra01
    ssh root@77.77.77.122 #hydra02
    vagrant destroy
```

## Tests:

    cl_status rscstatus -m #on hydra01 and hydra02
    web browser: 77.77.77.120:80
    /etc/init.d/httpd status #on hydra01 and hydra02
    /etc/init.d/heartbeat stop #on hydra01
    cl_status rscstatus -m #on hydra01 and hydra02
    web browser: 77.77.77.120:80
    /etc/init.d/httpd status #on hydra01 and hydra02
    look here: /var/log/ha-log

## Bibliography

- HA centos example with httpd service: http://www.howtoforge.com/high_availability_heartbeat_centos
- heartbeat clastering: http://www.linuxnix.com/2010/01/heartbeat-clustering.html
- haresources: http://www.linux-ha.org/wiki/Haresources
- heartbeat and pacemaker: http://library.linode.com/linux-ha/ip-failover-heartbeat-pacemaker-ubuntu-10.04#sph_configure-cluster-resources

## Copyright and license

Copyright 2012, Kamil Wilas (wilas.pl)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

