class repos::rpmforge {
	exec { 'curl -o rpmforge.rpm http://rpmforge.sw.be/redhat/el6/en/rpmforge/rpmforge/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm':
		cwd     => "/tmp",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		creates => "/tmp/rpmforge.rpm",
	}

	exec { 'rpm -ivh --force /tmp/rpmforge.rpm':
		cwd         => "/tmp",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
	}
}
