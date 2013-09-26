define rubyapp::deploy (
	$app_name = "pacuti",
	$app_domain = "unimedrj.com.br",
	$app_dir = "/var/www",
	$app_port = "3006",
	$repository = "git@git.unimedrj.com.br:pacuti.git",
) {
	rubyapp::install { "${app_name}-install":
		app_name   => "${app_name}",
		app_domain => "${app_domain}",
		app_dir    => "${app_dir}",
		app_port   => "${app_port}",
		repository => "${repository}",
	}

	rubyapp::config { "${app-name}-config":
		app_name   => "${app_name}",
		app_domain => "${app_domain}",
		app_dir    => "${app_dir}",
		app_port   => "${app_port}",
		repository => "${repository}",
	}

	rubyapp::service { "${app-name}-service":
		app_name   => "${app_name}",
		app_domain => "${app_domain}",
		app_dir    => "${app_dir}",
		app_port   => "${app_port}",
		repository => "${repository}",
	}
}

define rubyapp::install (
	$app_name = "pacuti",
	$app_domain = "unimedrj.com.br",
	$app_dir = "/var/www",
	$app_port = "3000",
	$repository = "git@git.unimedrj.com.br:pacuti.git",
) {
	file { "${app_name}-start":
		path   => "/usr/local/sbin/start-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/start-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/start-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}-stop":
		path   => "/usr/local/sbin/stop-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/stop-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/stop-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}-maint":
		path   => "/usr/local/sbin/maint-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/maint-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/maint-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}-deploy":
		path   => "/usr/local/sbin/deploy-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/deploy-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/deploy-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}-init":
		path    => "/etc/init.d/${app_name}",
		ensure  => present,
		content => template("rubyapp/app_name.service.erb"),
		owner   => 'root',
		group   => 'root',
		mode    => 0750,
	}
}

define rubyapp::config (
	$app_name = "pacuti",
	$app_domain = "unimedrj.com.br",
	$app_dir = "/var/www",
	$app_port = "3000",
	$repository = "git@git.unimedrj.com.br:pacuti.git",
) {
	file { "${app_name}-version":
		path   => "/usr/local/etc/${app_name}.${app_domain}.version",
		ensure => present,
		source => "puppet:///modules/rubyapp/${app_name}.${app_domain}.version",
		owner  => 'root',
		group  => 'root',
		mode   => 0644,
		notify => rubyapp::config,
	}

	exec { "${app_name}-apply":
		command => "/usr/local/sbin/deploy-rubyapp.${app_name}.sh ${app_dir} ${app_name}.${app_domain} ${repository}",
		cwd     => "${app_dir}",
		path    => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		notify  => rubyapp::service,
		refreshonly => true,
	}
}

define rubyapp::service (
	$app_name = "pacuti",
	$app_domain = "unimedrj.com.br",
	$app_dir = "/var/www",
	$app_port = "3000",
	$repository = "git@git.unimedrj.com.br:pacuti.git",
) {
	service  { "${app_name}":
		ensure     => running,
		hasstatus  => true,
		hasrestart => true,
		enable     => true,
	}	
}
