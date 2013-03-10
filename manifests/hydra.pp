# Node global
exec { 'clear-firewall':
    command     => '/sbin/iptables -F',
    refreshonly => true,
}
exec { 'persist-firewall':
    command     => '/sbin/iptables-save >/etc/sysconfig/iptables',
    refreshonly => true,
}
Firewall {
    subscribe => Exec['clear-firewall'],
    notify    => Exec['persist-firewall'],
}

# Include classes - search for classes in *.yaml/*.json files
hiera_include('classes')
# Classes order
Class['yum_repos'] -> Class['basic_package'] -> Class['user::root']
Class['basic_package'] -> Class['ha_apache']
# Extra firewall rules
firewall { '100 allow apache':
    state  => ['NEW'],
    dport  => '80',
    proto  => 'tcp',
    action => accept,
}
firewall { '100 allow heartbeat':
    state  => ['NEW'],
    dport  => '694',
    proto  => 'udp',
    action => accept,
}

# In real world from DNS
host { 'hydra01.farm':
    ip           => '77.77.77.121',
    host_aliases => 'hydra01',
}
host { 'hydra02.farm':
    ip           => '77.77.77.122',
    host_aliases => 'hydra02',
}

# Extra
class { 'heartbeat':
    master_node  => 'hydra01.farm',
    other_nodes  => ['hydra02.farm'],
    share_ip     => '77.77.77.120',
    ha_resources => ['httpd'],
    iface        => 'eth1',
    key          => 'simplekey',
    subscribe    => Class['ha_apache'],
}
# testing...
file { '/var/www/html/index.html':
    ensure  => file,
    owner   => 'root',
    group   => 'apache',
    mode    => '0644',
    content => "<html>${fqdn} apache node</html>",
    require => Class['ha_apache'],
}
