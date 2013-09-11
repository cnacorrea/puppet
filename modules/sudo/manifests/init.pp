class sudo::install {
	@package { sudo:
		ensure => present,
	}
}

define sudo::add_user($user) {
	search Sudo::Install
	realize(Package['sudo'])

	append_if_no_such_line { "$user":
		file => "/etc/sudoers",
		line => "${user} ALL=(ALL) NOPASSWD: ALL",
	}
}
