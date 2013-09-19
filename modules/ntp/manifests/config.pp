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

	file { '/var/lib/ntpstats':
		ensure => directory,
		owner  => 'ntp',
		group  => 'ntp',
		mode   => 0750,
		notify => Class["ntp::service"],
	}

	if $::osfamily == 'RedHat' {
		augeas { 'ntp-options':
			context => '/files/etc/sysconfig/ntpd',
			changes => 'set OPTIONS \'"-u ntp:ntp -p /var/run/ntpd.pid -g -c \'${ntp::params::ntp_config_file}\'"\'',
			notify  => Class["ntp::service"],
		}
	}
}
