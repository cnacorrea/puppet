node unimed inherits default {
	include user::virtual
	include user::redes-unimed
}

node unimed-banco inherits unimed {
	include user::dba-unimed
}

node rjofedlx212 inherits unimed-banco {
}

node rjofedlx213 inherits unimed-banco {
}

node rjofedlx214 inherits unimed-banco {
}
