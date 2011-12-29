package org.workflow4people.services

import com.sun.org.apache.bcel.internal.generic.RETURN;
import org.workflow4people.*

class WorkflowService {

    boolean transactional = false
    
    def findTasksByUser(username,params=[:]) {
    	Task.withTransaction { status ->
    		def person=Person.findByUsername(username)
    		params+=[fetch:[form:'join',workflow:'join']]
    		log.debug "PARAMS In SERVICE: ${params}"	
			
			def filterString = ""
			
			if ((params.processStatus) && (params.processStatus != "null") && (params.processStatus != "")) {
				filterString += "task.name like '" + params.processStatus + "%' and "				
			}
			
			if ((params.documentType) && (params.documentType != "null") && (params.documentType != "")) {
				filterString +=	"(task.workflow.name = '" + params.documentType + "' or task.workflow.name like '%" + params.documentType + "-%') and "
			}
			
			if ((params.fromDueDate) && (params.fromDueDate != "null") && (params.fromDueDate != "") && (params.toDueDate) && (params.toDueDate != "null") && (params.toDueDate != "")) {
				filterString =+ "task.dueDate between '" + params.fromDueDate + "' and '" + params.toDueDate + "' and"	
			}
						
			log.debug filterString
			
			def taskList=Task.executeQuery("select task from Task task where " + filterString + " task.completionDate = null and task.assignee = :person", [person: person], params)
			//def taskList=Task.findAllByAssigneeAndCompletionDateIsNull(person,params)
    		def taskCount=Task.executeQuery("select count(*) from Task task where " + filterString + " task.completionDate = null and task.assignee = :person", [person: person])
    		//def taskCount=Task.countByAssigneeAndCompletionDateIsNull(person,[:])
    	
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
    		authorities.eachWithIndex { a, i ->
    		  String auth = "authority_${i.toString()}"
    			authmap.put(auth,a)
    			query+=" or :${auth} in elements(task.candidateGroups)"
    		}
    		log.debug "The query is ${query}"
    		log.debug "params: ${params}"
    		println "params: ${params}"
    		def orderBy=""
    		
				for (def i = 0; i < params.sort.size(); i++) {				
					if (i == 0) {
						orderBy=" order by task.${params.sort[i]} ${params.order[i]}"
					}
					else {
						orderBy+=", task.${params.sort[i]} ${params.order[i]}"
					}
				}
				println "orderBy: ${orderBy}"
    		log.debug "Orderby: ${orderBy}"

			def filterString = ""
			
			if ((params.processStatus) && (params.processStatus != "null") && (params.processStatus != "")) {
				filterString += "task.name like '%" + params.processStatus + "%' and "				
			}
			
			if ((params.documentType) && (params.documentType != "null") && (params.documentType != "")) {
				filterString +=	"(task.workflow.name = '" + params.documentType + "' or task.workflow.name like '%" + params.documentType + "-%') and "
			}
			
			if ((params.fromDueDate) && (params.fromDueDate != "null") && (params.fromDueDate != "") && (params.toDueDate) && (params.toDueDate != "null") && (params.toDueDate != "")) {
				filterString += "task.dueDate between '" + params.fromDueDate + "' and '" + params.toDueDate + "' and"
			}
			
			log.debug "Applying filter : " + filterString
    		def taskList=Task.executeQuery("select task from Task task where " + filterString + " task.completionDate=null and (:person in elements(task.candidateUsers) "+query+")"+orderBy,authmap,params)    		
    		def taskCount=Task.executeQuery("select count(*) from Task task where " + filterString + " task.completionDate=null and (:person in elements(task.candidateUsers) "+query+")",authmap)
    	
    		[taskList:taskList,taskCount:taskCount]
    	}
    }
    
    def isTaskAssignee(taskId,username,params=[:]) {
      def isTaskAssignee = false
      
    	Task.withTransaction { status ->
    		params+=[fetch:[form:'join',workflow:'join']]
    	
    		def task=Task.get(taskId)
    		if (task && (task.assignee) && (task.assignee.username == username) && !task.completionDate) {
  	      isTaskAssignee = true
    		}
    	}
    	
    	return isTaskAssignee
    }
    
    def isTaskCandidate(taskId,username,params=[:]) {
      def isTaskCandidate = false
      
    	Task.withTransaction { status ->
    		def person=Person.findByUsername(username)
    		params+=[fetch:[form:'join',workflow:'join']]
    		def authorities=person.authorities
    		def authmap=[person:person]
    		String query=""
    		authorities.each { a ->
    			authmap.put(a.authority.replaceAll(" ", "_"),a)
    			query+=" or :${a.authority.replaceAll(" ", "_")} in elements(task.candidateGroups)"
    		}

    		params=[:]
    		def taskList=Task.executeQuery("select task from Task task where task.id=${taskId} and task.completionDate=null and (:person in elements(task.candidateUsers) "+query+")",authmap,params)
    		
    	  if (taskList.size() > 0) {
    	    isTaskCandidate = true
    	  }
    	}
    	
    	return isTaskCandidate
    }
    
    
    
    def getTask(id) {
    	
    	Task.withSession { 
    		return Task.get(id)
    	}
    	
    	
    }
    
    def getTaskStatuses() {
		return TaskStatus.findAll([sort:'title',order:'asc'])
	}
    

 }
