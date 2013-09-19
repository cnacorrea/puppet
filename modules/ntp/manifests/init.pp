class ntp {
	include ntp::params, ntp::install, ntp::config, ntp::service
}

class ntp::params {
	case $::osfamily {
		Debian: {
			$ntp_package_name = 'ntp'
			$ntp_config_file = '/etc/ntp.conf'
			$ntp_service_name = 'ntp'
		}
		RedHat: {
			$ntp_package_name = 'ntp'
			$ntp_config_file = '/etc/ntp.conf'
			$ntp_service_name = 'ntpd'
		}
		default: {
			fail("${::hostname}: This module does not support operating system ${::osfamily}")
		}
	}
}

class ntp::install {
	package { $ntp::params::ntp_package_name:
		ensure => installed,
	}
}

class ntp::config {
	file { $ntp::params::ntp_config_file:
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => 0640,
		source => "puppet:///modules/ntp/ntp.conf",
		require => Class["ntp::install"],
		notify => Class["ntp::service"],
	}
}

class ntp::service {
	service { $ntp::params::ntp_service_name:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Class["ntp::config"],
	}
}
