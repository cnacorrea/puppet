class ntp::config {
	file { $ntp::params::ntp_config_file:
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => 0640,
		source  => "puppet:///modules/ntp/ntp.conf",
		require => Class["ntp::install"],
		notify  => Class["ntp::service"],
	}

	file { '/etc/localtime':
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		source  => "puppet:///modules/ntp/${ntp::params::ntp_localtime_file}",
		notify  => Class["ntp::service"],
		replace => $ntp::params::ntp_localtime_replace,
	}
}
