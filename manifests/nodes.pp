node default {
	include puppet
	include sudo
}

node 'billmbp' {
	include puppet
}

node 'otrs' inherits default {
	include repos::rpmforge
}
