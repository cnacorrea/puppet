class jdk160_18 {
	exec { "install-jdk1.6.0_18":
		command => 'wget -O /opt/jdk1.6.0_18.tbz http://cnacorrea.it/software/jdk1.6.0_18.tbz && tar xjvf jdk1.6.0_18.tbz',
		cwd	=> "/opt",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		notify  => Exec["rm-tbz-jdk1.6.0_18"],
		creates => "/opt/jdk1.6.0_18",
	}

	exec { "rm-tbz-jdk1.6.0_18":
		command     => 'rm -f /opt/jdk1.6.0_18.tbz',
		cwd         => "/opt",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		refreshonly => true,
	}
}
