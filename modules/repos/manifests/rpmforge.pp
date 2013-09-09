class repos::rpmforge {
	exec { 'rpm -ivh --force http://78.46.17.228/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm':
		cwd  => "/tmp",
		path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
	}
}
