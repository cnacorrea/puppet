class jdk160_18 {
	case $::architecture {
		/(x86_64|amd64)/: {
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

			file { "/etc/profile.d/jdk160_18.sh":
				ensure => present,
				source => 'puppet:///modules/jdk160_18/jdk160_18.sh',
				owner  => 'root',
				group  => 'root',
				mode   => '0755',
			}
		}
		default: {
			warning("The jdk160_18 class is for x86_64/amd64 systems only! This machine is ${::architecture}.")
		}
	}
}
