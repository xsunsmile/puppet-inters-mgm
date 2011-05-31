

define inters::mongofile_get {

	include inters::sync
	include inters::executable

	exec { "mongofile_get_${name}":
		command => "mongo_get mongodb_host ${name} && echo ''",
		require => [
			Service["mongodb"],
			File['/usr/bin/mongo_get'],
			Line['mongodb_host_pub'],
		],
	}
}
