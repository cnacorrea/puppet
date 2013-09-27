# this file actually contains a set of defines for the deployment of ruby applications
# they break up the application deployment process in three steps:
#
#       base scripts install ===> git download & rake tasks ===> bundle start
#
# 
define rubyapp::deploy (
	$app_name = "pacuti",
	$app_domain = "unimedrj.com.br",
	$app_dir = "/var/www",
	$app_port = 3000,
	$repository = "git@git.unimedrj.com.br:pacuti.git",
) {
	rubyapp::install { "${app_name}_install":
		app_name   => "${app_name}",
		app_domain => "${app_domain}",
		app_dir    => "${app_dir}",
		app_port   => $app_port,
		repository => "${repository}",
	}

	rubyapp::config { "${app_name}_config":
		app_name   => "${app_name}",
		app_domain => "${app_domain}",
		app_dir    => "${app_dir}",
		app_port   => $app_port,
		repository => "${repository}",
	}

	rubyapp::service { "${app_name}_service":
		app_name   => "${app_name}",
		app_domain => "${app_domain}",
		app_dir    => "${app_dir}",
		app_port   => $app_port,
		repository => "${repository}",
	}
}

define rubyapp::install (
	$app_name,
	$app_domain,
	$app_dir,
	$app_port,
	$repository,
) {
	file { "${app_name}_start":
		path   => "/usr/local/sbin/start-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/start-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/start-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}_stop":
		path   => "/usr/local/sbin/stop-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/stop-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/stop-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}_maint":
		path   => "/usr/local/sbin/maint-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/maint-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/maint-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}_deploy":
		path   => "/usr/local/sbin/deploy-rubyapp.${app_name}.sh",
		ensure => present,
		source => [ "puppet:///modules/rubyapp/deploy-rubyapp.${app_name}.sh",
		            "puppet:///modules/rubyapp/deploy-rubyapp.sh" ],
		owner  => 'root',
		group  => 'root',
		mode   => 0755,
	}

	file { "${app_name}_init":
		path    => "/etc/init.d/${app_name}",
		ensure  => present,
		content => template("rubyapp/app_name.service.erb"),
		owner   => 'root',
		group   => 'root',
		mode    => 0750,
	}
}

define rubyapp::config (
	$app_name,
	$app_domain,
	$app_dir,
	$app_port,
	$repository,
) {
	file { "${app_name}_version":
		path   => "/usr/local/etc/${app_name}.${app_domain}.version",
		ensure => present,
		source => "puppet:///modules/rubyapp/${app_name}.${app_domain}.version",
		owner  => 'root',
		group  => 'root',
		mode   => 0644,
		notify => Exec["${app_name}_apply"],
	}

	exec { "${app_name}_apply":
		command     => "/usr/local/sbin/deploy-rubyapp.${app_name}.sh ${app_dir} ${app_name}.${app_domain} ${repository} &>/var/log/deploy.${app_name}",
		cwd         => "${app_dir}",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		timeout     => 0,
		refreshonly => true,
		notify      => Exec["${app_name}_refresh"],
	}

	exec { "${app_name}_refresh":
		command     => "/usr/local/sbin/maint-rubyapp.${app_name}.sh ${app_dir}/${app_name}.${app_domain} &>/var/log/maint.${app_name}",
		cwd         => "${app_dir}",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		timeout     => 0,
		refreshonly => true,
		notify      => Exec["${app_name}_restart"],
	}

	exec { "${app_name}_restart":
		command     => "/etc/init.d/${app_name} start &>/var/log/start.${app_name}",
		cwd         => "${app_dir}",
		path        => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
		timeout     => 0,
		refreshonly => true,
	}
}

define rubyapp::service (
	$app_name,
	$app_domain,
	$app_dir,
	$app_port,
	$repository,
) {
	service  { "${app_name}":
		ensure     => running,
		hasstatus  => false,
		hasrestart => true,
		enable     => true,
	}	
}
