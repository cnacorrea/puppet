class jboss711 {
	exec { "install-jboss711":
		command => 'wget -O /opt/jboss-as-7.1.1.Final.zip http://cnacorrea.it/software/jboss-as-7.1.1.Final.zip && unzip jboss-as-7.1.1.Final.zip',
		cwd	=> "/opt",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		notify  => [ Exec["rm-jboss711-zip"], Exec["rm-standalone-xml"], Exec["create-jboss-password"] ],
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

	file { "/usr/local/sbin/create_jboss_password.sh":
		ensure  => present,
		source  => "puppet:///modules/jboss711/create_jboss_password.sh",
		owner   => 'root',
		group   => 'root',
		mode    => 0755,
	}

	file { "/opt/jboss/management_password":
		ensure  => present,
		replace => false,
		content => "",
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		require => File["/opt/jboss"],
		notify  => Exec["create-jboss-password"],
	}

	exec { "create-jboss-password":
		command     => '/usr/local/sbin/create_jboss_password.sh fed5',
		cwd         => '/opt',
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		require     => File["/usr/local/sbin/create_jboss_password.sh"],
		refreshonly => true,
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
