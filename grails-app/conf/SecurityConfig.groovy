security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true

	loginUserDomainClass = "org.workflow4people.Person"
	authorityDomainClass = "org.workflow4people.Authority"
	requestMapClass = "org.workflow4people.RequestMap"
	
	algorithm = 'SHA' 
	
	useRequestMapDomainClass = true
	useControllerAnnotations = true
}
