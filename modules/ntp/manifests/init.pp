class ntp {
	if $::virtual == physical {
		include ntp::params, ntp::install, ntp::config, ntp::service
	} else {
		warn("Tried to enable ntp on a ${::virtual} virtual machine. For the sake of reliability, I'm NOT doing it. Please, check ${::virtual} good practices for timekeeping.")
	}
}
