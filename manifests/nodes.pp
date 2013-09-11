node default {
	include puppet
	include user::virtual
	include user::redes-unimed
}

node 'billmbp' {
	include puppet
}

node 'otrs' inherits default {
	include repos::rpmforge
}
