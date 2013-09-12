class puppet {
	include puppet::params

	file { '/usr/local/bin/confdir':
		source => 'puppet:///modules/puppet/confdir.sh',
		mode   => '0755',
	}

	file { '/usr/local/bin/papply':
		source => 'puppet:///modules/puppet/papply.sh',
		mode   => '0755',
	}

	file { '/usr/local/bin/pull-updates':
		source => 'puppet:///modules/puppet/pull-updates.sh',
		mode   => '0755',
	}

	user { 'confman':
		comment => 'Configuration Management user',
		home    => "${puppet::params::confdir}",
		groups  => [ $puppet::params::sudogroup ],
	}

	ssh_authorized_key { 'confman-mbp':
		user    => 'confman',
		ensure  => 'present',
		type    => 'ssh-rsa',
		key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCwDpVxbyevf68EFJIVMnA83H0gLMMrgZpAoqVNcm3TqJKvYrdXrc3SYAKkjOrqAC5pNHmht1T/bAmLjXLodaQFx702ek3A8V3o5gvnnW90mvGc78/qq3VCG8ytLiR+NS6sg2w/njCuMM4qYsFy8Mj6S7jBYePvx1DpjrEywabc/4llpCeP6H/USZmGnMWDsVanRBE2YzkL/lFRKz1QCQpvOpCZdxQMg6YUkRH63cb0RrWJsTQQuHY566Df8xwdtBycv6Cn3PhtLJbq9xMXcDEpHxPtLLNuL93P5bWCS/DtzQcvCqRzVSiAaiQwg7OAbo4C4LSIBlZKZukiLvJ9keoH',
		name    => 'confman-mbp',
		require => User['confman'],
	}

	exec { "confman-sudo":
		command => "echo \"confman ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers",
		cwd     => "/etc",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		unless  => "grep \"^confman ALL=(ALL) NOPASSWD: ALL\" /etc/sudoers",
	}

	file { "${puppet::params::confdir}":
		ensure  => "directory",
		owner   => 'confman',
		group   => 'confman',
		recurse => true,
	}

	file { "${puppet::params::confdir}/.ssh":
		ensure  => "directory",
		require => File["${puppet::params::confdir}"],
		owner   => 'confman',
		group   => 'confman',
		recurse => true,
	}

	file { "${puppet::params::confdir}/.ssh/id_rsa":
		source  => 'puppet:///modules/puppet/confman.priv',
		owner   => 'confman',
		mode    => '0600',
		require => File["${puppet::params::confdir}"],
	}

	cron { 'run-puppet':
		ensure  => 'present',
		command => '/usr/local/bin/pull-updates',
		minute  => '*/10',
		hour    => '*',
		user    => 'confman',
	}
}
