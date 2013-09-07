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
