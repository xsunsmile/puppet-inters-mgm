
class inters {

	if $hostname == $torque::params::torque_master {
		include inters::sync_master
	} else {
		include inters::sync
	}

	include inters::cron
	include inters::executable

}
