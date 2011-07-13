package org.workflow4people.services

import org.workflow4people.*

class FindUserGroupsEndpoint {
  
	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
    log.debug("Processing FindUserGroups service request")
		
		def nameLike = request.name
		
		def userGroupList = Authority.withCriteria {
      like('authority', "%${nameLike}%")
      order('authority', 'asc')
		}
		
		def response = 
		  {
		    FindUserGroupsResponse(xmlns: namespace) {
		      userGroups {
    	      userGroupList.each { aUserGroup -> 
    				  userGroup {
    					  name aUserGroup.authority
							  description aUserGroup.description
							  type aUserGroup.authorityType
						  }
					  }
					}
				}
			}
      
    return response
  }
  
}
