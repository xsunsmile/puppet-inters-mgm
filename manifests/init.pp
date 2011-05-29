
require 'fpm'

class inters {
	include inters::sync
	include inters::cron
	include inters::executable
	include inters::functions
	include fpm
}
