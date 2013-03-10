class heartbeat ( $master_node, $other_nodes, $share_ip, $ha_resources = [], $iface = 'eth0', $key='test!password!' ){

    package { 'heartbeat':
        ensure => installed,
    }

    service { 'heartbeat':
        ensure  => running,
        enable  => true,
        require => Package['heartbeat'],
    }

    file { '/etc/ha.d/authkeys':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template('heartbeat/authkeys.erb'),
        notify  => Service['heartbeat'],
        require => Package['heartbeat'],
    }

    file { '/etc/ha.d/haresources':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('heartbeat/haresources.erb'),
        notify  => Service['heartbeat'],
        require => Package['heartbeat'],
    }

    file { '/etc/ha.d/ha.cf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('heartbeat/ha.cf.erb'),
        notify  => Service['heartbeat'],
        require => Package['heartbeat'],
    }
}
