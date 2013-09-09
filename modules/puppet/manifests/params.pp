class puppet::params {
	case $operatingsystem {
		Darwin: {
			$confdir = '/Users/confman'
			# TODO: add sudo group for Mac OS X
			$sudogroup = 'users'
		}
		Ubuntu: {
			$confdir = '/home/confman'
			$sudogroup = 'sudo'
		}
		default: {
			$confdir = '/home/confman'
			$sudogroup = 'admin'
		}
	}	
}
