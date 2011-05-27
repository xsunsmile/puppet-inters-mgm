
class inters::sync {

	$hostname_s = extlookup('hostname_s')
	$mongodb_host = extlookup('mongodb_host')

	line { 'mongodb_host_pub':
		file => "/etc/hosts",
		line => "${mongodb_host}	mongodb-master	mongodb_host",
	}

	line { 'mongodb_host_pri':
		file => "/etc/hosts",
		line => "${ipaddress}	mongodb-master-pri	mongodb_host_pri",
	}

	exec { "add_host":
		path => "/bin:/usr/bin",
		command => $hostname_s ?{
			'absent' => "mongo_host put",
			default => "mongo_host put ${hostname_s}",
		},
		require => [ Service['mongodb'], File['/usr/bin/mongo_host'] ],
		before => File["/tmp/torque/fetch.sh"],
	}

}
