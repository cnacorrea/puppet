node 'billmbp' {
	file { '/tmp/hello':
		content => "Hello, world\n",
	}
}
