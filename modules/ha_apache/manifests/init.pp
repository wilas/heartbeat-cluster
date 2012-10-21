class ha_apache ( $listen_ip = "*", $listen_port = "80"  ) {

    package { "httpd":
        ensure => installed,
    }

    firewall { "100 allow apache":
        state  => ['NEW'],
        dport  => '80',
        proto  => 'tcp',
        action => accept,
    }

    service { "httpd":
        #ensure     => running, #heartbeat change on running...
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require    => Package["httpd"],
        subscribe  => [ File["/etc/httpd/conf/httpd.conf"], File["/etc/httpd/conf.d"] ],
    }

    #update: DefaultType text/html
    file {
        "/etc/httpd/conf/httpd.conf":
            ensure  => file,
            owner   => "root",
            group   => "root",
            mode    => "0644",
            content => template("ha_apache/httpd.conf.erb"),
            require => Package["httpd"];
        "/etc/httpd/conf.d":
            ensure  => directory,
            owner   => "root",
            group   => "root",
            mode    => "0644",
            recurse => true,
            require => Package["httpd"];
        "/etc/httpd/conf.d/welcome.conf":
            content => "NameVirtualHost $listen_ip:$listen_port",
            require => [Package["httpd"],File["/etc/httpd/conf.d"]],
            notify  => Service["httpd"];
    }
}

