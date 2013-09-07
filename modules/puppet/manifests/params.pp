class puppet::params {
	case $operatingsystem {
		Darwin: {
			$confdir = '/Users/confman'
		}
		default: {
			$confdir = '/home/confman'
		}
	}	
}
