
define inters::mongofile_put {
	import 'inters::sync'
	exec { "mongofile_put_${name}":
		command => "mongofiles -r --host mongodb_host put ${name}",
		require => [
			Service["mongodb"],
			Line['mongodb_host_pub'],
		],
	}
}

