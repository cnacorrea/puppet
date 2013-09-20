class jboss711::service {
	service { "jboss-as-standalone":
		ensure     => running,
		hasstatus  => true,
		hasrestart => true,
		enable     => true,
		require    => Class["jboss711::install"],
	}
}
