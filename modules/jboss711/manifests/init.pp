class jboss711 (
	$email_contact = $jboss711::params::default_email_contact,
) {
	include jboss711::install, jboss711::service
}

class jboss711::install {
	group { "jboss-as":
		ensure => present,
	}

	user { "jboss-as":
		gid     => "jboss-as",
		shell   => "/sbin/nologin",
		comment => "JBoss Management Account",
		home    => "/opt/jboss",
		require => Group["jboss-as"],
	}

	exec { "install-jboss711":
		command => 'wget -O /opt/jboss-as-7.1.1.Final.zip http://cnacorrea.it/software/jboss-as-7.1.1.Final.zip && unzip jboss-as-7.1.1.Final.zip && chown -R jboss-as:jboss-as jboss-as-7.1.1.Final && chmod -R o-rwx jboss-as-7.1.1.Final',
		cwd	=> "/opt",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		notify  => [ Exec["rm-jboss711-zip"], Exec["rm-standalone-xml"], Exec["create-jboss-password"] ],
		creates => "/opt/jboss-as-7.1.1.Final",
		require => User["jboss-as"],
	}

	exec { "rm-jboss711-zip":
		command     => 'rm -f /opt/jboss-as-7.1.1.Final.zip',
		cwd         => "/opt",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		refreshonly => true,
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

	exec { "rm-standalone-xml":
		command     => 'rm -f /opt/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml',
		cwd         => "/opt",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		refreshonly => true,
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
		command     => "su - -c '/usr/local/sbin/create_jboss_password.sh ${contact}'",
		cwd         => '/opt',
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		require     => File["/usr/local/sbin/create_jboss_password.sh"],
		refreshonly => true,
	}

	file { "/etc/jboss-as":
		ensure  => directory,
		owner   => 'jboss-as',
		group   => 'jboss-as',
		mode    => 0700,
		require => User["jboss-as"],
	}
}
