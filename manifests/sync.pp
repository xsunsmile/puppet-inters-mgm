
class inters::sync {

	include inters::executable

	$hostname_s = extlookup('hostname_s')
	$mongodb_host = extlookup('mongodb_host')

	line { 'mongodb_host_pub':
		file => "/etc/hosts",
		line => "${mongodb_host}	mongodb-master	mongodb_host",
	}

	exec { "add_host":
		path => "/bin:/usr/bin",
		command => $hostname_s ?{
			'absent' => "mongo_host put",
			default => "mongo_host put ${hostname_s}",
		},
		require => [ Service['mongodb'], File['/usr/bin/mongo_host'] ],
	}

	if $hostname == $torque::params::torque_master {
		include torque::compile
		Exec["add_host"] {
			before +> File["/tmp/torque/fetch.sh"],
		}
	}
}
