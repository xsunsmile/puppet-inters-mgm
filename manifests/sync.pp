
class inters::sync {

	include inters::executable

	$hostname_s = extlookup('hostname_s')
	$mongodb_host = extlookup('mongodb_host')
	$has_mongodb_line = has_line('/etc/hosts',"mongodb-master.*$")

	if $has_mongodb_line {
		line { 'mongodb_host_pub':
			ensure => absent,
			file => "/etc/hosts",
			line => "mongodb-master",
		}
	}

	line { 'mongodb_host_pub':
		file => "/etc/hosts",
		line => "${mongodb_host}	mongodb-master	mongodb_host",
	}

	exec { "add_host":
		path => "/bin:/usr/bin",
		command => $hostname_s ?{
			'' => "mongo_host put",
			default => "mongo_host put ${hostname_s}",
		},
		require => [ Service['mongodb'], File['/usr/bin/mongo_host'] ],
	}

}
