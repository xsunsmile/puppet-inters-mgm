
class inters::sync {

	$hostname_s = extlookup('hostname_s')

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
	}

	define mongofile_put {
		exec { "mongofile_put_${name}":
			command => "mongofiles -r --host mongodb_host put ${name}",
			require => [
				Service["mongodb"],
				Line['mongodb_host_pub'] 
			],
		}
	}

	define mongofile_get {
		exec { "mongofile_get_${name}":
			command => "mongo_get mongodb_host ${name} && echo ''",
			require => [
				File['/usr/bin/mongo_get'],
				Service["mongodb"],
				Line['mongodb_host_pub']
			],
		}
	}

}
