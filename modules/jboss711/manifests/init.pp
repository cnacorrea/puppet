class jboss711 (
	$email_contact = "suporte@unimedrj.coop.br",
) {
	class { jboss711::install:
		email_contact => "${email_contact}",
	}

	include jboss711::service
}
