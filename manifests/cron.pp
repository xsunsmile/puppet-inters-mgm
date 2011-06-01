
class inters::cron {

	exec { 'stop-cron':
		command => '/etc/init.d/cron stop',
	}

	exec { 'start-cron':
		command => '/etc/init.d/cron start',
		require => Exec['stop-cron'],
	}

	cron { 'sync_hosts':
		ensure => present,
		command => "/usr/bin/mongo_host sync_to_etchosts",
		user => root,
		minute => '*/1',
		require => Exec['start-cron'],
	}

}

