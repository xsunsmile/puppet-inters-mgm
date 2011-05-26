
class inters::functions {

	define mongofile_put {
		exec { "mongofile_put_${name}":
			command => "mongofiles -r --host mongodb_host put ${name}",
			require => [
				Service["mongodb"],
				Line['mongodb_host_pub'],
			],
		}
	}

	define mongofile_get {
		exec { "mongofile_get_${name}":
			command => "mongo_get mongodb_host ${name} && echo ''",
			require => [
				File['/usr/bin/mongo_get'],
				Service["mongodb"],
				Line['mongodb_host_pub'],
			],
		}
	}

}
