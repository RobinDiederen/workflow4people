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
				filterString =+ "task.dueDate between '" + params.fromDueDate + "' and '" + params.toDueDate + "' and "	
			}
			
			if (params.documentIndexes && (params.documentIndexes != null) && (params.documentIndexes.size() > 0)) {
				params.documentIndexes.each {
					filterString += "(select count(*) from DocumentIndex documentIndex where (documentIndex.document = task.workflow.document) and (documentIndex.name = '${it.key}') and (documentIndex.value like '%${it.value}%')) > 0 and "
				}
			}
						
			log.debug filterString
			
			def taskList=Task.executeQuery("select task from Task task where " + filterString + " task.completionDate = null and task.assignee = :person", [person: person], params)
    		def taskCount=Task.executeQuery("select count(*) from Task task where " + filterString + " task.completionDate = null and task.assignee = :person", [person: person])
    	
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
    		def orderBy=""
    		
				for (def i = 0; i < params.sort.size(); i++) {				
					if (i == 0) {
						orderBy=" order by task.${params.sort[i]} ${params.order[i]}"
					}
					else {
						orderBy+=", task.${params.sort[i]} ${params.order[i]}"
					}
				}
    		log.debug "Orderby: ${orderBy}"

			def filterString = ""
			
			if ((params.processStatus) && (params.processStatus != "null") && (params.processStatus != "")) {
				filterString += "task.name like '%" + params.processStatus + "%' and "				
			}
			
			if ((params.documentType) && (params.documentType != "null") && (params.documentType != "")) {
				filterString +=	"(task.workflow.name = '" + params.documentType + "' or task.workflow.name like '%" + params.documentType + "-%') and "
			}
			
			if ((params.fromDueDate) && (params.fromDueDate != "null") && (params.fromDueDate != "") && (params.toDueDate) && (params.toDueDate != "null") && (params.toDueDate != "")) {
				filterString += "task.dueDate between '" + params.fromDueDate + "' and '" + params.toDueDate + "' and "
			}
			
			if (params.documentIndexes && (params.documentIndexes != null) && (params.documentIndexes.size() > 0)) {
				params.documentIndexes.each {
					switch (it.key) {
						case "\$/Document/id": 
							filterString += "(task.workflow.document.id = '${it.value}') and "
						break
						case "lastUpdated": 
							filterString += "(task.workflow.document.lastUpdated like '${it.value}%') and "
						break
						case "documentType": 
							filterString += "(task.workflow.document.documentType.name = '${it.value}') and "
						break
						case "completionDate": 
							filterString += "(task.workflow.document.completionDate like '${it.value}%') and "
						break
						case "user": 
							filterString += "(task.workflow.document.user = '${it.value}') and "
						break
						case "documentStatus": 
							filterString += "(task.workflow.document.documentStatus = '${it.value}') and "
						break
						case "dateCreated": 
							filterString += "(task.workflow.document.dateCreated like '${it.value}%') and "
						break
						case "documentDescription": 
							filterString += "(task.workflow.document.documentDescription = '${it.value}') and "
						break
						case "groupID": 
							filterString += "(task.workflow.document.groupID = '${it.value}') and "
						break
						case "processingDays": 
							filterString += "(task.workflow.document.processingDays = '${it.value}') and "
						break
						default:
							filterString += "(select count(*) from DocumentIndex documentIndex where (documentIndex.document = task.workflow.document) and (documentIndex.name = '${it.key}') and (documentIndex.value like '%${it.value}%')) > 0 and "
						break
					}
				}
			}
    	
			log.debug "Applying filter : " + filterString
    		def taskList=Task.executeQuery("select task from Task task where " + filterString + " task.completionDate=null and (:person in elements(task.candidateUsers)"+query+")"+orderBy,authmap,params)
  			def taskCount=Task.executeQuery("select count(*) from Task task where " + filterString + " task.completionDate=null and (:person in elements(task.candidateUsers)"+query+")",authmap)
    		
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
    		authorities.eachWithIndex { a, i ->
    		  String auth = "authority_${i.toString()}"
    			authmap.put(auth,a)
    			query+=" or :${auth} in elements(task.candidateGroups)"
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
