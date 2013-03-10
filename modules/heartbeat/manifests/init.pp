class heartbeat {

    $master_node = hiera('heartbeat::master_node',undef)
    $other_nodes = hiera_array('heartbeat::other_nodes',undef)
    $share_ip = hiera('heartbeat::share_ip',undef)
    $ha_resources = hiera_array('heartbeat::ha_resources',[])
    $iface = hiera('heartbeat::iface','eth0')
    $key = hiera('heartbeat::key','test!password!')

    if $master_node != undef and $other_nodes != undef and $share_ip != undef {
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
}
