
class inters::cron {

	$gem_path = gem_path()

	# exec { 'stop-cron':
	# 	command => '/etc/init.d/cron stop',
	# }

	# exec { 'start-cron':
	# 	command => '/etc/init.d/cron start',
	# 	require => Exec['stop-cron'],
	# }

	cron { 'sync_hosts':
		ensure => present,
		command => "/usr/bin/mongo_host sync_to_etchosts",
		user => root,
		minute => '*/1',
	}

	cron { 'cron_puppet':
		environment => "PATH=\$PATH:${gem_path}",
		ensure => present,
		command => "puppetd --test --verbose | tee -a /tmp/cron_puppet.log",
		user => root,
		minute => '*/30',
	}

	cron { 'update_puppet_modules':
		environment => "PATH=\$PATH:${gem_path}",
		ensure => present,
		command => "cd /etc/puppet/modules && sh update.sh | tee -a /tmp/update_puppet.log",
		user => root,
		minute => '*/5',
	}

}

