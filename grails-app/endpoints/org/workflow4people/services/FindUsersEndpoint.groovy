package org.workflow4people.services

import org.workflow4people.*

class FindUsersEndpoint {
  
	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
    log.debug("Processing FindUsers service request")
		
		def realNameLike = request.realName
		
		def userList = Person.withCriteria {
		  //TODO like..
      order('familyName', 'asc')
      order('givenName', 'asc')
		}
		
		def response = 
		  {
		    FindUsersResponse(xmlns: namespace) {
		      users {
    	      userList.each { aUser -> 
    				  user {
    					  name aUser.username
							  realName aUser.userRealName
							  familyName aUser.familyName
							  givenName aUser.givenName
							  email aUser.email
						  }
					  }
					}
				}
			}
      
    return response
  }
  
}
