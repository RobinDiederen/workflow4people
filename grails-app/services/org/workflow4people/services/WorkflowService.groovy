package org.workflow4people.services

import com.sun.org.apache.bcel.internal.generic.RETURN;
import org.workflow4people.*

class WorkflowService {

    boolean transactional = true
    
    def findTasksByUser(username,params=[:]) {
    	Task.withTransaction { status ->
    		def person=Person.findByUsername(username)
    		params+=[fetch:[form:'join',workflow:'join']]
    		println "PARAMS In SERVICE: ${params}"

    	
    		def taskList=Task.findAllByAssigneeAndCompletionDateIsNull(person,params)
    		def taskCount=Task.countByAssigneeAndCompletionDateIsNull(person,[:])
    	
    		[taskList:taskList,taskCount:taskCount]
    	}
    	
    }
    
    def findTasksByCandidate(username,params=[:]) {
    	Task.withTransaction { status ->
    		def person=Person.findByUsername(username)
    		params+=[fetch:[form:'join',workflow:'join']]
    		def authorities=person.authorities
    		def authmap=[person:person]
    		String query=""
    		authorities.each { a ->
    			authmap.put(a.authority,a)
    			query+=" or :${a.authority} in elements(task.candidateGroups)"
    		}
    		println "The query is ${query}"
    		println "params: ${params}"
    		def orderBy=""
    			
    		if (params["order"]) {
    			orderBy=" order by task.${params['sort']} ${params['order']}"
    		}
    		println "Orderby: ${orderBy}"

    		
    		def taskList=Task.executeQuery("select task from Task task where task.completionDate=null and (:person in elements(task.candidateUsers) "+query+")"+orderBy,authmap,params)
    		def taskCount=Task.executeQuery("select count(*) from Task task where task.completionDate=null and (:person in elements(task.candidateUsers) "+query+")",authmap)
    	[taskList:taskList,taskCount:taskCount]
    	}
    }
    
    
    
    def getTask(id) {
    	
    	Task.withSession { 
    		return Task.get(id)
    	}
    	
    	
    }
    
    
    
    

 }
