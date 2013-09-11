class accounts {
	add_user { fed1:
		name       => "Mario Petraglia",
		shell      => "/bin/bash",
		sshkeytype => "ssh-rsa",
		sshkey     => "AAAAB3NzaC1yc2EAAAABJQAAAIBTFJxqNxfGHprCVnVxMf9AvG7zjtNHH/5g/28YXPin9V2XIcvJvPTEFtAhl6OKaXvNk+RPatI5wTU8dxGoB6A5J6360XvU5Gl3iBZL7yhk9mcJ0MBsMxIeqMLRCLc/oMYG7pmYajjRc1QLoRYIvnNARLk8nqVTjPw9XCGwB6c8QQ==",
		team       => "redes-unimed",
	}

	add_user { fed2:
		name       => "Raphael Frattiani",
		shell      => "/bin/bash",
		sshkeytype => "ssh-rsa",
		sshkey     => "AAAAB3NzaC1yc2EAAAABJQAAAQEArtK52iqaFxryCE3erKnjKrwyipwCJoQkIbwEgqjEs0BhPDCWKMuGwkQIo/Rn2dglHq6ypxYr/lb7SZpW0TCwLG2Oi8rY9pZm5lodMUoU6v5FLpZFCX5vvK827fXtulOU/j9DLt2vlZP5/zXXBSM0sv4Qg/x/3P9f23GIABnKRd50p8UJvo3wYqTZHM5aQNZujrgZVww0ZO9Rl/9VZI9C7Vn2oq6vveGPGbHZ8Uc9yuKG2RqC6IFe3fL79eN/pou3P+uCY/W8bE88lqBsMXTv8Wx2DE4Qukkpu18I5K5sHyV/+k2H5AFhK7hYMcN8lCE4XkGqDK+umEXAn3rhufJeew==",
		team       => "redes-unimed",
	}

	add_user { fed3:
		name       => "Gutemberg Araujo",
		shell      => "/bin/bash",
		sshkeytype => "ssh-rsa",
		sshkey     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDKyzflpnkrQLOREiqhfYTsFtdySc9FRku4Xz6VQlx4Vi2Ks1wFGd+1hhfScY/FsLUxWoouxyqI5fiw99JpKsW6umpyvrxrvURcG83XJwZsJ20XRZWWUzESYwCRTsBNsWiMxN9fpUsafMsYYuFn8+2s5ja2yj8NetPdymfpJhNYubYtzrkXVtPPWE9RZR23Oj5LdddYE37V57MFNmWSNCKJe7Vl1hmaCCor7LHZ/X8alsbDKslTp5cG7UDKXSMUre1BuXts6loWVNCxDiYwHsi3lJaGuIfEkQYzV3hWimtQ6JO96hU97ZgeGPHO1ImTnNmAad5CvS9R1Lu6gyhYDQut",
		team       => "redes-unimed",
	}

	add_user { fed4:
		name       => "Neilton Paiva",
		shell      => "/bin/bash",
		sshkeytype => "ssh-rsa",
		sshkey     => "AAAAB3NzaC1yc2EAAAABIwAAAQEArHbnChFfflX7MGpjhLrM3bpsWJKug9mtae1+U/nBmIqmyBISgIyvpUNtOEj4jKqz8XPZW+YceEi4jxRzcIXcdRAXyvlaBgZFojpyH7omKshGZf01TmP85R0iSzuV/3W/sPCrVA04P2EIBtx6nRT5M2zjdpOfKOsvsn81CS1nfDmbw/Y7qLm8Hz/YFZtxh3wq8q1VIEp+RXl0e6sCPVdYL/s0k73tXcs0xRCE7VbQaDI1p4PuPZDMmJd5OXO53tQekGgzTBB7nfDHeehVWcikYpLR6h69cJz85DiZZOM8dTajLKHIFXNt+QKNhsI2e71NWS0xc5o4LMaDUTJNV7BtFw==",
		team       => "redes-unimed",
	}

	add_user { fed5:
		name       => "Carlos 'Bill' Nilton",
		shell      => "/bin/bash",
		sshkeytype => "ssh-rsa",
		sshkey     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCwDpVxbyevf68EFJIVMnA83H0gLMMrgZpAoqVNcm3TqJKvYrdXrc3SYAKkjOrqAC5pNHmht1T/bAmLjXLodaQFx702ek3A8V3o5gvnnW90mvGc78/qq3VCG8ytLiR+NS6sg2w/njCuMM4qYsFy8Mj6S7jBYePvx1DpjrEywabc/4llpCeP6H/USZmGnMWDsVanRBE2YzkL/lFRKz1QCQpvOpCZdxQMg6YUkRH63cb0RrWJsTQQuHY566Df8xwdtBycv6Cn3PhtLJbq9xMXcDEpHxPtLLNuL93P5bWCS/DtzQcvCqRzVSiAaiQwg7OAbo4C4LSIBlZKZukiLvJ9keoH",
		team       => "redes-unimed",
	}
}

define add_user($name, $shell, $sshkeytype, $sshkey, $team) {
	$username = $title

	user { $username:
		comment => "$name",
		home    => "/home/$username",
		shell   => "$shell",
		tag     => "$team",
	}

	file { "/home/${username}":
		ensure  => "directory",
		require => User["${username}"],
		owner   => $username,
		group   => $username,
		recurse => false,
		tag     => "$team",
	}

	file { "/home/${username}/.ssh":
		ensure  => "directory",
		require => File["/home/${username}"],
		owner   => $username,
		group   => $username,
		recurse => true,
		tag     => "$team",
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
