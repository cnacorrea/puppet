node default {
	include puppet
	include sudo
	include ntp
}

node ubuntuvm inherits default {
}

node unimed inherits default {
	include user::virtual
	include user::redes-unimed
}

node unimed-banco inherits unimed {
	include user::dba-unimed
}

node 'billmbp' {
	include puppet
}

node 'otrs' inherits default {
	include repos::rpmforge
}

node rjolnx008 inherits unimed-banco {
}

node rjofedlx212 inherits unimed-banco {
	include jdk160_18
	include jboss711
	include union
}

node rjofedlx213 inherits unimed-banco {
}

node rjofedlx214 inherits unimed-banco {
}

node rjofedlx215 inherits unimed-banco {
}

node rjofedlx219 inherits unimed-banco {
}

node rjodmzlx003 inherits unimed-banco {
}

# 341 200
node 'unicoo.angra.unimed.com.br' inherits unimed-banco {
}

# 248 200
node 'bpilnx010' inherits unimed-banco {
}

# 248 201
node 'homologa.barrapirai.unimed.com.br' inherits unimed-banco {
}

# 052 200
node 'bmalnx004.barramansa.unimed.com.br' inherits unimed-banco {
}

# 052 201
node 'bmalnx08.barramansa.unimed.com.br' inherits unimed-banco {
}

# 231 200
node 'unicoo.costaverde.unimed.com.br' inherits unimed-banco {
}

# 231 201
node 'homologa.costaverde.unimed.com.br' inherits unimed-banco {
}

# 023 200
node 'oralnx001.novaiguacu.unimed.com.br' inherits unimed-banco {
}

# 077 200
node 'unicoo.itaperuna.unimed.com.br' inherits unimed-banco {
}

# 296 200
node 'producao.mvalenca.unimed.com.br' inherits unimed-banco {
}

# 296 201
node 'homologa.mvalenca.unimed.com.br' inherits unimed-banco {
}

# 126 200
node 'unicoo.noroesterj.unimed.com.br' inherits unimed-banco {
}

# 126 201
node 'homologa.noroesterj.unimed.coop.br' inherits unimed-banco {
}

# 205 200
node 'oracle.campos.unimed.com.br' inherits unimed-banco {
}
