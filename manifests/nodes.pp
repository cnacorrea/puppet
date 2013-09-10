node default {
	include puppet
}

node 'billmbp' inherits default {
	include puppet
}

node 'ubuntuvm' inherits default {
	include puppet
	include accounts
}

node 'otrs' inherits default {
	include puppet
	include repos::rpmforge
}
