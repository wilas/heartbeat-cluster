stage { "base": before  => Stage["main"] }
stage { "last": require => Stage["main"] }

class { "yum_repos": stage     => "base" }
class { "basic_package": stage => "base" }
class { "user::root": stage    => "base" }
Class["yum_repos"] -> Class["basic_package"] -> Class["user::root"]

#hosts:
host { "hydra01.farm":
    ip          => "77.77.77.121",
    host_aliases => "hydra01",
}

host { "hydra02.farm":
    ip          => "77.77.77.122",
    host_aliases => "hydra02",
}

#firewall manage
service { "iptables":
    ensure => running,
    enable => true,
}
exec { 'clear-firewall':
    command => '/sbin/iptables -F',
    refreshonly => true,        
}
exec { 'persist-firewall':
    command => '/sbin/iptables-save >/etc/sysconfig/iptables',
    refreshonly => true,
}
Firewall {
    subscribe => Exec['clear-firewall'],
    notify => Exec['persist-firewall'],
}

class { "basic_firewall": }

# Extra
class { 'ha_apache':
    listen_ip   => "77.77.77.120",
    listen_port => "80",
}

class { 'heartbeat':
    master_node  => 'hydra01.farm',
    other_nodes  => ['hydra02.farm'],
    share_ip     => "77.77.77.120",
    ha_resources => ["httpd"],
    iface        => "eth1",
    key          => "simplekey",
    subscribe    => Class["ha_apache"],
}

#testing...
file { "/var/www/html/index.html":
    ensure  => file,
    owner   => "root",
    group   => "apache",
    mode    => "0644",
    content => "<html>$fqdn apache node</html>",
    require => Class["ha_apache"],
}

