
class inters::sync_master inherits inters::sync {

		include torque::compile

		Exec["add_host"] {
			before +> File["/tmp/torque/fetch.sh"],
		}

}
