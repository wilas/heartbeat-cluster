# Description
high-availability clustering using Heartbeat - httpd service example

## VM description:

 - OS: Scientific linux 6
 - master node: hydra01
 - other node: hydra02

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

