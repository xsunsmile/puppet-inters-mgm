
class inters::executable {

	file { "/usr/bin/mongo_host":
		ensure => present,
		owner => root,
		group => root,
		mode => 0755,
		content => template("inters/mongo_host.sh.erb"),
		require => [ Package['ruby'], Package['mongo'] ]
	}

	file { '/usr/bin/mongo_get':
		mode => "755",
		owner => root,
		group => root,
		content => template("inters/mongo_get.sh.erb"),
		require => [ Package['ruby'], Package['mongo'] ]
	}

}
