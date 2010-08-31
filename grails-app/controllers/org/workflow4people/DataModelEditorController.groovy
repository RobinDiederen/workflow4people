package org.workflow4people

class DataModelEditorController {

	def grailsApplication
	
    def index = { 
    		render(view:'editor')
    		
    }
    
    def showField = {
            def fieldInstance = Field.get( params.id )

            if(!fieldInstance) {
                flash.message = "Field not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldInstance : fieldInstance ] }
        }
    
    
    
    def editField = {
            def fieldInstance = Field.get( params.id )

            if(!fieldInstance) {
                flash.message = "Field not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldInstance : fieldInstance ] }
        }
    
    
    def submit = {
    		println "Hey!"
    		def fieldInstance = Field.get( params.id )
    		render(view:'showField',model:[ fieldInstance : fieldInstance ])
    		
    }
    
    def edit = {
    		println "Hey!"
    		def fieldInstance = Field.get( params.id )
    		render(view:'editField',model:[ fieldInstance : fieldInstance ])
    		
    }
    
    def showFieldList = {
            def fieldListInstance = FieldList.get( params.id )

            if(!fieldListInstance) {
                flash.message = "FieldList not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldListInstance : fieldListInstance ] }
        }

	def editFieldList = {
            def fieldListInstance = FieldList.get( params.id )

            if(!fieldListInstance) {
                flash.message = "FieldList not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldListInstance : fieldListInstance ] }
        }

	

    def beforemove = {
    		println params
    		Boolean canMove=true
    		if (params.node_rel=="rootFieldList") {
    			canMove=false;
    		}
    		canMove=true
    		render(contentType:"text/json") {
    			result(
    					returnValue:canMove,
    					message:'ooooh een berichtje'
    				)
    		}
    }
    
    def beforemoveadvice = {
    		println params
    		String theAdvice="asis"
			if (params.node_rel=="rootFieldList") {
    			theAdvice="copy";
    		}
    		
    		/*render(contentType:"text/json") {
    			result(
    					advice:theAdvice,
    					message:'ooooh een berichtje'
    				)
    		}*/
    		
        	render(builder:'json') {
        		result(
    					advice:theAdvice,
    					message:'ooooh een berichtje'
    				)
        		        	  
          	}
    		
    		
    		
    }
    
    def onmove = {
    		println "We have a move. ${params.node_id} is now ${params.type} ${params.ref_node_id}"
    		println params
    		
    		def id=params.node_id.split('_')[1]
    		def theField=org.workflow4people.Field.get(id)
    		println theField
    		
    		def refId=params.ref_node_id.split('_')[1]
     		def refField=org.workflow4people.Field.get(refId)
    		println refField
    		
    		def moveType=params.type
    		
    		theField.fieldList=refField.fieldList
    		def n=1
    		org.workflow4people.Field.findAllByFieldList(theField.fieldList,[sort:'fieldPosition',order:'asc']).each { field -> 
    			if (field == refField) {
    				if (moveType=="before") {
    					theField.fieldPosition=n
    					theField.save()
    					n++
    					field.fieldPosition=n
    					field.save()
    					n++
    					
    				} else {
    					// after
    					field.fieldPosition=n
    					field.save()
    					n++
    					theField.fieldPosition=n
    					theField.save()
    					n++
    				}
    			} else {
    				if (field !=theField) {
    					field.fieldPosition=n
    					field.save()
    					n++
    				}
				}
			}
    		
    		
    		
    		
    		render(contentType:"text/json") {
    			result(
    					returnValue:true,
    					message:'ooooh een berichtje'
    				)
    		}
    }
    
    def oncopy = {
    		println "We have a copy. ${params.node_id} is now ${params.type} ${params.ref_node_id}"
    		println params
    		
    		def nodeType=params.node_rel
    		def id=params.node_id.split('_')[1]
    		                                 
    		                                 
    		println "nodeType=${nodeType},id=${id}"
    		//def theField=org.workflow4people.Field.get(id)
    		//println theField
    		
    		def refNodeType=params.ref_node_rel
    		def refId=params.ref_node_id.split('_')[1]
    		                                        
            println "refNodeType=${refNodeType},refNodeId=${refId}"
            
     		def refField=org.workflow4people.Field.get(refId)
     		
     		def theField=new Field()
     		if (nodeType=="rootFieldList") {
     			println "Creating new field referring to FieldList"
     			theField.fieldType=org.workflow4people.FieldType.findByName('FieldList')
     			def fieldList=FieldList.get(id)
     			theField.childFieldList=fieldList
     			// convert first chat to lowercase
     			theField.name=fieldList.name[0].toLowerCase()+fieldList.name.substring(1)		
     			theField.fieldList=refField.fieldList
     			theField.label=fieldList.label
     			theField.description=""
     		} else {
     			// copy the field
     			println "Copying field"
     			def originalField=Field.get(id)
     			def domainClass=grailsApplication.getDomainClass('org.workflow4people.Field') 
     			domainClass.persistentProperties.each { prop ->
     				theField."${prop.name}" = originalField."${prop.name}"
     			}     			
     		}
     			
     		
     		
    		
    		
    		def moveType=params.type
    		
    		theField.fieldList=refField.fieldList    		
    		def n=1
    		org.workflow4people.Field.findAllByFieldList(theField.fieldList,[sort:'fieldPosition',order:'asc']).each { field -> 
    			if (field == refField) {
    				if (moveType=="before") {
    					theField.fieldPosition=n
    					theField.save(failOnError:true)
    					n++
    					field.fieldPosition=n
    					field.save(failOnError:true)
    					n++
    					
    				} else {
    					// after
    					field.fieldPosition=n
    					field.save(failOnError:true)
    					n++
    					theField.fieldPosition=n
    					theField.save(failOnError:true)
    					n++
    				}
    			} else {
    				if (field !=theField) {
    					field.fieldPosition=n
    					field.save(failOnError:true)
    					n++
    				}
				}
			}
    		
    		render(contentType:"text/json") {
    			result(
    					returnValue:true,
    					message:'ooooh een berichtje',
    					fieldId:theField.id
    				)
    		}
    }
    
    
    
    def beforedelete = {
    		println params    		
    		Boolean canMove=true
    		if (params.node_rel=="rootFieldList") {
    			canMove=false;
    		}
    		
    		
    		render(contentType:"text/json") {
    			result(
    					returnValue:canMove,
    					message:'ooooh een berichtje'
    				)
    		}
    }
    
    
}
