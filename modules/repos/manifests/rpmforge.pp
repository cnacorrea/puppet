class repos::rpmforge {
	exec { 'rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt':
		cwd     => "/tmp",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
	}

	exec { 'yum install http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm':
		cwd         => "/tmp",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
	}
}
