node default {
	include puppet
	include accounts
}

node 'billmbp' {
	include puppet
}

node 'otrs' inherits default {
	include repos::rpmforge
}
