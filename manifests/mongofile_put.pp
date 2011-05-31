
define inters::mongofile_put {

	include inters::sync
	include inters::executable

	exec { "mongofile_put_${name}":
		command => "mongofiles -r --host mongodb_host put ${name}",
		require => [
			Service["mongodb"],
			Replace['mongodb_host_pub'],
		],
	}
}

