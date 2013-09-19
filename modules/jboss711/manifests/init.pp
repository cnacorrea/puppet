class jboss711 {
	exec { "install-jboss711":
		command => 'wget -O /opt/jboss-as-7.1.1.Final.zip http://cnacorrea.it/software/jboss-as-7.1.1.Final.zip && unzip jboss-as-7.1.1.Final.zip',
		cwd	=> "/opt",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		notify  => [ Exec["rm-jboss711-zip"], Exec["rm-standalone-xml"] ],
		creates => "/opt/jboss-as-7.1.1.Final",
	}

	file { "/opt/jboss":
		ensure  => link,
		target  => '/opt/jboss-as-7.1.1.Final',
		owner   => 'root',
		group   => 'root',
		require => Exec["install-jboss711"],
	}

	file { "/opt/jboss-as-7.1.1.Final/bin/standalone.conf":
		ensure  => present,
		source  => "puppet:///modules/jboss711/standalone.conf",
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		require => Exec["install-jboss711"],
	}

	file { "/opt/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml":
		ensure  => present,
		replace => false,
		source  => "puppet:///modules/jboss711/standalone.xml",
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		require => Exec["install-jboss711"],
	}

	exec { "rm-standalone-xml":
		command     => 'rm -f /opt/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml',
		cwd         => "/opt",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		refreshonly => true,
	}

	exec { "rm-jboss711-zip":
		command     => 'rm -f /opt/jboss-as-7.1.1.Final.zip',
		cwd         => "/opt",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		refreshonly => true,
	}
}
