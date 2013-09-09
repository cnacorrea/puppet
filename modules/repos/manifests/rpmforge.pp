class repos::rpmforge {
	exec { 'rpm -ivh --force http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm':
		cwd  => "/tmp",
		path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
	}
}
