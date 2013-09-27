# classes should always include these modules
node default {
	include puppet
	include sudo
	include ntp
}

# to do some testing over my ubuntu vms
node ubuntuvm inherits default {
}

# a default node for unimed' systems
node unimed inherits default {
	include user::virtual
	include user::redes-unimed
}

# database systems must have dba account
node unimed-database inherits unimed {
	include user::dba-unimed
}

# for testing over my "desktop" MBP
node 'billmbp' {
	include puppet
}

# 972 unicoo
node rjolnx008 inherits unimed-database {
}

# 972 app.d
node rjofedlx212 inherits unimed-database {
	include jdk160_18

	class { "jboss711":
		email_contact => "suportefabrica@unimedrj.coop.br",
	}

	include union
}

# 972 app.h
node rjofedlx213 inherits unimed-database {
	rubyapp::deploy { "trabalheconosco":
		app_name   => "trabalheconosco",
		app_domain => "h.unimedrj.com.br",
		app_dir    => "/var/www",
		app_port   => 3004,
		repository => "git://git.unimedrj.com.br/trabalheconosco/trabalheconosco.git",
	}

	rubyapp::deploy { "pacuti":
		app_name   => "pacuti",
		app_domain => "h.unimedrj.com.br",
		app_dir    => "/var/www",
		app_port   => 3006,
		repository => "git@git.unimedrj.com.br:pacuti/pacuti.git",
	}
}

# 972 + ProviderIT Continuous Integration
node rjofedlx214 inherits unimed-database {
}

# 972 DwWeb production
node rjofedlx215 inherits unimed-database {
}

# 972 app.s
node rjofedlx219 inherits unimed-database {
}

# 972 web production
node rjodmzlx003 inherits unimed-database {
	rubyapp::deploy { "trabalheconosco":
		app_name   => "trabalheconosco",
		app_domain => "unimedrj.com.br",
		app_dir    => "/var/www",
		app_port   => 3004,
		repository => "git://git.unimedrj.com.br/trabalheconosco/trabalheconosco.git",
	}
}

# 341 200
node 'unicoo.angra.unimed.com.br' inherits unimed-database {
}

# 248 200
node 'bpilnx010' inherits unimed-database {
}

# 248 201
node 'homologa.barrapirai.unimed.com.br' inherits unimed-database {
}

# 052 200
node 'bmalnx004.barramansa.unimed.com.br' inherits unimed-database {
}

# 052 201
node 'bmalnx08.barramansa.unimed.com.br' inherits unimed-database {
}

# 231 200
node 'unicoo.costaverde.unimed.com.br' inherits unimed-database {
}

# 231 201
node 'homologa.costaverde.unimed.com.br' inherits unimed-database {
}

# 023 200
node 'oralnx001.novaiguacu.unimed.com.br' inherits unimed-database {
}

# 077 200
node 'unicoo.itaperuna.unimed.com.br' inherits unimed-database {
}

# 296 200
node 'producao.mvalenca.unimed.com.br' inherits unimed-database {
}

# 296 201
node 'homologa.mvalenca.unimed.com.br' inherits unimed-database {
}

# 126 200
node 'unicoo.noroesterj.unimed.com.br' inherits unimed-database {
}

# 126 201
node 'homologa.noroesterj.unimed.coop.br' inherits unimed-database {
}

# 205 200
node 'oracle.campos.unimed.com.br' inherits unimed-database {
}
