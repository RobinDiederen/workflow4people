package org.workflow4people.services

import org.workflow4people.*

class DmeService {
	//static scope='session'
	def grailsApplication
    boolean transactional = false    
	
	def treeCopy(Field field) {
		
		def copyField=new Field()
		def domainClass=grailsApplication.getDomainClass('org.workflow4people.Field')
			domainClass.persistentProperties.each { prop ->
				copyField."${prop.name}" = field."${prop.name}"
			}
			Field.findAllByParent(field).each { childField ->
				println "CHILDFIELD ${childField}"
				def copyChildField=treeCopy(childField)
				copyChildField.parent=copyField
				copyChildField.save()
				
			}
		copyField.parent=null
		return copyField
	}
	
	def treeDelete(Field field) {
		Field.findAllByParent(field).each { childField ->
			println "CHILDFIELD ${childField}"
			treeDelete(childField)
		}
		field.parent=null
		field.delete(flush:true)
	}
	
	
	def moveField(Field field1,Field field2,String where){
		def originalParent=field1.parent
		
		switch(where) {
		
			case "inside":
				field1.parent=field2
				def maxPosition=Field.findAllByParent(field2,[sort:'fieldPosition',order:'desc',max:1])[0]?.fieldPosition
				field1.fieldPosition=maxPosition ? maxPosition+1 : 1
				field1.save(flush:true)
				break
				
			case "before":
				field1.parent=field2.parent
				
				def position=field2.fieldPosition
				field1.fieldPosition=field2.fieldPosition
				field1.save(flush:true)
				
				def n=1
				Field.findAllByParent(field2.parent,[sort:'fieldPosition',order:'asc']).each { field ->
					field.fieldPosition=n++
					field.save(flush:true)
					log.debug "${field.name}: ${field.fieldPosition}"
				}
								
				if (field1.fieldPosition>field2.fieldPosition) {
					log.debug "Swapping ${field1.id} and ${field2.id}"
					swapFieldPosition(field1,field2)
				}
				
				Field.findAllByParent(field2.parent,[sort:'fieldPosition',order:'asc']).each { field ->
					log.debug "${field.name}: ${field.fieldPosition}"
				}
				
														
				break
			case "after":
				
				field1.parent=field2.parent
				
				def position=field2.fieldPosition
				field1.fieldPosition=field2.fieldPosition
				field1.save(flush:true)
				
				def n=1
				Field.findAllByParent(field2.parent,[sort:'fieldPosition',order:'asc']).each { field ->
					field.fieldPosition=n++
					field.save(flush:true)
				}
				
				if (field1.fieldPosition<field2.fieldPosition) {
					swapFieldPosition(field1,field2)
				}
								
				break	
		}
		// Fix the fieldPositions of the original part of the tree
		if(originalParent) {
			def n=1
			Field.findAllByParent(originalParent,[sort:'fieldPosition',order:'asc']).each { field ->
			field.fieldPosition=n++
			field.save(flush:true)
		}
	
		}
		
		
		
	}
	
	def swapPosition(item1,item2) {
		def p1= item1.position
		def p2 = item2.position
		item1.position=p2
		item2.position=p1
	}
	
	def swapFieldPosition(item1,item2) {
		def p1= item1.fieldPosition
		def p2 = item2.fieldPosition
		item1.fieldPosition=p2
		item2.fieldPosition=p1
		item1.save(flush:true)
		item2.save(flush:true)
	}
	
	def camelCase(String s) {
		return s.substring(0,1).toLowerCase()+s.substring(1)
	}
	
	/*
	 * Returns true if field is allowed to be placed on this form
	 * Checks if field is in this workflow's XML document tree
	 */
	def allowFieldOnForm(Field field,Form form) {
		def fieldType=form?.workflow?.documentType?.fieldType
		log.debug "allowFieldOnForm: fieldType is ${fieldType?.name}"
		if (!field) return false
		def f=field
		def okay=f.fieldType==fieldType
		while ((f.parent!=null && f.parent!=f)&& !okay) {
			f=f.parent
			log.debug "Checking field#${f.id} (${f.name},type ${f.fieldType.name})"
			if(f.fieldType==fieldType) {				
				okay=true
			}			
		}
		return okay
	}
	
	
}
