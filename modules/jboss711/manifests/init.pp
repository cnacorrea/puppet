class jboss711 {
	exec { "install-jboss711":
		command => 'wget -O /opt/jboss-as-7.1.1.Final.zip http://cnacorrea.it/software/jboss-as-7.1.1.Final.zip && unzip jboss-as-7.1.1.Final.zip',
		cwd	=> "/opt",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		notify  => Exec["rm-jboss711-zip"],
		creates => "/opt/jboss-as-7.1.1.Final",
	}

	file { "/opt/jboss":
		ensure => link,
		target => '/opt/jboss-as-7.1.1.Final',
		owner  => 'root',
		group  => 'root',
	}

	exec { "rm-jboss711-zip":
		command     => 'rm -f /opt/jboss-as-7.1.1.Final.zip',
		cwd         => "/opt",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		refreshonly => true,
	}
}
