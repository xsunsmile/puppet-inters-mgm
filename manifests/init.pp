
class inters {

	cron { 'sync_hosts':
		ensure => present,
		command => "/usr/bin/mongo_host sync_to_etchosts",
		user => root,
		munite => 5,
	}

}
