
class inters::cron {

	cron { 'sync_hosts':
		ensure => present,
		command => "/usr/bin/mongo_host sync_to_etchosts",
		user => root,
		minute => '*/1',
	}

}

