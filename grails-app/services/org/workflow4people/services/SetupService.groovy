package org.workflow4people.services
import org.workflow4people.*

class SetupService {

    boolean transactional = true
	def springSecurityService
	
	def addAuthority(name) {
		println "Adding authority ${name}"
		def authority=new Authority();
		authority.authority=name
		authority.save(failOnError:true)
	}
	def addUser(username,password,userRealName,email,authorities) {
		println "Adding user ${username}"
		def person=new Person();
		person.username=username
		person.passwd=springSecurityService.encodePassword("admin")
		person.userRealName="Administrator"
		person.email=email
		person.save(failOnError:true)
		authorities.each { authorityName ->
			def authority=Authority.findByAuthority(authorityName)
			if (!authority) {
				addAuthority(authorityName)
				authority=Authority.findByAuthority(authorityName)
			}
			authority.addToPeople(person);
		}		
	}
	
	def addAction(name,title,description) {
		def action=new Action()
		action.name=name
		action.title=title
		action.description=description
		action.save(failOnError:true)
	}
	
	def addRole(name,title,description,actions) {
		def role=new Role()
		role.name=name
		role.title=title
		role.description=description
		role.save(failOnError:true)
		actions.each { actionName ->
			def action=Action.findByName(actionName)
			if (!action) {
				addAction(actionName)
				action=Action.findByName(actionName)
			}			
			role.addToRoleAction(action)			
		}
	}
	
	
    def setup() {
		println "Hi. I'm the setup service."
		/*
		def authorityCount=Authority.count()
		if (authorityCount==0) {
			addAuthority("ROLE_WF4P_ADMIN")			
		}
		*/
		def personCount=Person.count();
		if (personCount==0) {
			addUser("admin","admin","Administrator","admin@open-t.nl",["ROLE_WF4P_ADMIN"]);						
		}
		
		// Actions
		if (Action.count()==0) {
			addAction("show","Show","Show")
			addAction("request","Request","Request a process")
			addAction("review","Review","Review a request")
			addAction("handle","Hanlde","Handle a task")
		}
		
		// Roles
		if (Role.count()==0) {
			addRole("requestor","Requestor","Requestor",["handle","request","show"])
			addRole("handler","Handler","Handler",["handle","request","show"])
			addRole("observer","Observer","Observer",["show"])
			addRole("manager","Manager","Manager",["review","handle","request","show"])
		}
		
		// ...
    }
}
