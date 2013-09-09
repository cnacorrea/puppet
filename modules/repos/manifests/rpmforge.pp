class repos::rpmforge {
	file { '/tmp/RPM-GPG-KEY.dag.txt':
		source  => "puppet:///modules/repos/RPM-GPG-KEY.dag.txt",
		creates => '/tmp/RPM-GPG-KEY.dag.txt',
		notify  => Exec['rpmforge-install'],
	}

	file { '/tmp/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm':
		source  => "puppet:///modules/repos/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm",
		creates => '/tmp/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm',
		notify  => Exec['rpmforge-install'],
	}

	exec { 'rpmforge-install':
		command     => 'rpm --import /tmp/RPM-GPG-KEY.dag.txt && yum localinstall /tmp/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm',
		cwd         => "/tmp",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		refreshonly => true,
	}
}
