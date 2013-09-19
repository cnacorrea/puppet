class ntp {
	if $::virtual == physical {
		include ntp::params, ntp::install, ntp::config, ntp::service
	} else {
		warning("Tried to enable ntp on a ${::virtual} virtual machine. For the sake of reliability, I'm DISABLING it. Please, check ${::virtual} good practices for timekeeping.")

		include ntp::params

		service { $ntp::params::ntp_service_name:
			ensure => stopped,
			hasstatus => true,
			hasrestart => true,
			enable => false,
		}
	}
}
