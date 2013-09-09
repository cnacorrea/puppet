class repos::rpmforge {
	exec { 'rpm -ivh --force http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm':
		cwd  => "/tmp",
		path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
	}
}
