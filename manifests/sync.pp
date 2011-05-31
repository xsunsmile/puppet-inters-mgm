
class inters::sync {

	include inters::executable

	$hostname_s = extlookup('hostname_s')
	$mongodb_host = extlookup('mongodb_host')

	replace { 'mongodb_host_pub':
		file => "/etc/hosts",
		pattern => "^${mongodb_host}	mongodb.*$",
		replacement => "${mongodb_host}	mongodb-master	mongodb_host",
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
