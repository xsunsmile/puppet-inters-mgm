
class inters::cron {

	$gem_path = gem_path()

	package { 'postfix': ensure => present }

	exec { 'restart-cron':
		command => '/etc/init.d/cron restart',
		require => Package['postfix'],
	}

#	cron { 'set-env':
#		ensure => present,
#		command => "echo ''",
#		month => '1',
#	 	require => Exec['restart-cron'],
#	}

	cron { 'sync_hosts':
		ensure => present,
		environment => "PATH=/bin:/usr/bin:/usr/local/bin:${gem_path}",
		command => "/usr/bin/mongo_host sync_to_etchosts || true",
		user => root,
		minute => '*/3',
	}

	# cron { 'cron_puppet':
	# 	ensure => present,
	# 	command => "puppetd --test --verbose | tee -a /tmp/cron_puppet.log",
	# 	user => root,
	# 	minute => '*/5',
	# }

	if $hostname == extlookup('torque_master_name') {
		cron { 'update_puppet_modules':
			ensure => present,
			command => "cd /etc/puppet/modules && ./update.sh | tee -a /tmp/update_puppet.log",
			user => root,
			minute => '*/5',
		}
	}

}

