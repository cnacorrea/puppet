node default {
	include puppet
}

node 'billmbp' {
	include puppet

	file { '/tmp/hello':
		content => "Hello, world\n",
	}
}

node 'ubuntuvm' {
	include puppet

	file { '/tmp/hello':
		content => "Hello, world\n",
	}
}

node 'otrs' {
	include puppet
	include repos::rpmforge
