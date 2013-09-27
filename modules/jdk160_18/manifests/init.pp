# this is a class for a jdk install
# right now, it only does the install of a single version
# the plan is to have a parameterized structure to allow for the install
# of multiple, different versions
# -- cn@cnacorrea.it
# 
class jdk160_18 {

	# most server machines are x86_64 by now. no intention of having a i686 version for this
	#
	case $::architecture {
		/(x86_64|amd64)/: {

			# download and uncompresses Java
			# after the install, notifies the removal Exec to delete the downloaded file
			#
			exec { "install-jdk1.6.0_18":
				command => 'wget -O /opt/jdk1.6.0_18.tbz http://cnacorrea.it/software/jdk1.6.0_18.tbz && tar xjvf jdk1.6.0_18.tbz',
				cwd	=> "/opt",
				path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
				notify  => Exec["rm-tbz-jdk1.6.0_18"],
				creates => "/opt/jdk1.6.0_18",
			}

			# ensures /opt/java points to the correct place
			# its reasonable to have this done only after the jdk has been uncompressed
			#
			file { "/opt/java":
				ensure  => link,
				target  => "/opt/jdk1.6.0_18",
				owner   => 'root',
				group   => 'root',
				require => Exec["install-jdk1.6.0_18"],
			}

			# the compressed Java used to to the install can be removed
			#
			exec { "rm-tbz-jdk1.6.0_18":
				command     => 'rm -f /opt/jdk1.6.0_18.tbz',
				cwd         => "/opt",
				path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
				refreshonly => true,
			}

			# includes a profile script to have correct java vars for all users
			#
			file { "/etc/profile.d/jdk160_18.sh":
				ensure => present,
				source => 'puppet:///modules/jdk160_18/jdk160_18.sh',
				owner  => 'root',
				group  => 'root',
				mode   => '0644',
			}
		}
		default: {
			warning("The jdk160_18 class is for x86_64/amd64 systems only! This machine is ${::architecture}.")
		}
	}
}
