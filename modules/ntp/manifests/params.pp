class ntp::params {
	case $::osfamily {
		Debian: {
			$ntp_package_name = 'ntp'
			$ntp_config_file = '/etc/ntp.conf'
			$ntp_service_name = 'ntp'
		}
		RedHat: {
			$ntp_package_name = 'ntp'
			$ntp_config_file = '/etc/ntpd.conf'
			$ntp_service_name = 'ntpd'
		}
		default: {
			fail("${::hostname}: This module does not support operating system ${::osfamily}")
		}
	}

	case $::timezone {
		BRT: {
			$ntp_localtime_file = 'localtime'
			$ntp_localtime_replace = true
		}
		default: {
			$ntp_localtime_file = 'localtime'
			$ntp_localtime_replace = false
		}
	}
}
