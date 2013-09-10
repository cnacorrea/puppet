class accounts {
	add_user { fed5:
		name       => "Carlos 'Bill' Nilton",
		shell      => "/bin/bash",
		sshkeytype => "ssh-rsa",
		sshkey     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCwDpVxbyevf68EFJIVMnA83H0gLMMrgZpAoqVNcm3TqJKvYrdXrc3SYAKkjOrqAC5pNHmht1T/bAmLjXLodaQFx702ek3A8V3o5gvnnW90mvGc78/qq3VCG8ytLiR+NS6sg2w/njCuMM4qYsFy8Mj6S7jBYePvx1DpjrEywabc/4llpCeP6H/USZmGnMWDsVanRBE2YzkL/lFRKz1QCQpvOpCZdxQMg6YUkRH63cb0RrWJsTQQuHY566Df8xwdtBycv6Cn3PhtLJbq9xMXcDEpHxPtLLNuL93P5bWCS/DtzQcvCqRzVSiAaiQwg7OAbo4C4LSIBlZKZukiLvJ9keoH",
	}
}

define add_user($name, $shell, $sshkeytype, $sshkey) {
	$username = $title

	user { $username:
		comment => "$name",
		home    => "/home/$username",
		shell   => "$shell",
	}

	file { "/home/${username}":
		ensure  => "directory",
		require => User["${username}"],
		owner   => $username,
		group   => $username,
		recurse => true,
	}

	file { "/home/${username}/.ssh":
		ensure  => "directory",
		require => File["/home/${username}"],
		owner   => $username,
		group   => $username,
		recurse => true,
	}

	if $sshkeytype != 'none' {
		ssh_authorized_key{ $username:
			user   => "$username",
			ensure => present,
			type   => "$sshkeytype",
			key    => "$sshkey",
			name   => "$username"
		}

		ssh_authorized_key{ "confman-${username}":
			user   => "confman",
			ensure => present,
			type   => "$sshkeytype",
			key    => "$sshkey",
			name   => "confman-${username}"
		}
	}
}
