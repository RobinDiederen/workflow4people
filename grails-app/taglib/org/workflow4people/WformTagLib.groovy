/*

 * Workflow4people
 * Copyright 2009-2010, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */


/**
 * Tag library for Workflow4people
 * This tag library is used for the console application.
 *
 * @author Joost Horward
 */
package org.workflow4people
import org.codehaus.groovy.grails.commons.* 
class WformTagLib {
	
	static namespace = 'w'
		
	def treeList = { attrs ->
		  // a simple attrs.fieldList.field.each would not work - it gets the elements in the wrong order
		  Field.findAllByFieldList(attrs.fieldList,[sort:'fieldPosition',order:'asc']).each({
		  if (it.childFieldList){
			    out << "<li class=\"fieldlist\" id=\"l${it.id}\"><span id=\"${it.id}\" class=\"folder fieldlist\"  >${it.name} [${it.childFieldList.name}]</span>\n"
			    out << "<ul>"
				def lattrs = [fieldList:it.childFieldList]
				//println it.childFieldList
				treeList.call(lattrs)
				out << "</ul></li>"
			}
			else {
				out << "<li class=\"field\" id=\"l${it.id}\"><span id=\"${it.id}\" class=\"file field\" >${it.name}</span></li>\n"
			}
		})
	}
	
	def tree = { attrs ->
	  // a simple attrs.fieldList.field.each would not work - it gets the elements in the wrong order
	  Field.findAllByFieldList(attrs.fieldList,[sort:'fieldPosition',order:'asc']).each({
	  if (it.childFieldList){
		    out << "<li class=\"open field\" id=\"l${it.id}\"><a class=\"file field\" href=\"#\" id=\"${it.id}\"><ins>&nbsp;</ins>${it.name} [${it.childFieldList.name}]</a>\n"
		    out << "<ul>"
			def lattrs = [fieldList:it.childFieldList]
			//println it.childFieldList
			tree.call(lattrs)
			out << "</ul></li>"
		}
		else {
			out << "<li class=\"field\" id=\"l${it.id}\"><a class=\"file field\" href=\"#\" id=\"${it.id}\"><ins>&nbsp;</ins>${it.name}</a></li>\n"
		}
	})
	}
	
	def oldModelTree = { attrs ->
	  // a simple attrs.fieldList.field.each would not work - it gets the elements in the wrong order
	  Field.findAllByFieldList(attrs.fieldList,[sort:'fieldPosition',order:'asc']).each({
	  if (it.childFieldList){
		    out << "<li rel=\"fieldList\" class=\"open field\" id=\"field_${it.id}\"><a class=\"file field\" href=\"#\" id=\"${it.id}\"><ins>&nbsp;</ins>${it.name} [${it.childFieldList.name}]</a>\n"
		    out << "<ul>"
			def lattrs = [fieldList:it.childFieldList]
			//println it.childFieldList
			modelTree.call(lattrs)
			out << "</ul></li>"
		}
		else {
			out << "<li rel=\"field\" class=\"field\" id=\"field_${it.id}\"><a class=\"file field\" href=\"#\" id=\"${it.id}\"><ins>&nbsp;</ins>${it.name}</a></li>\n"
		}
	})
		
	}
	
	def modelTree = { attrs ->
	  // a simple attrs.fieldList.field.each would not work - it gets the elements in the wrong order
	if(attrs.field) {
	  Field.findAllByParent(attrs.field,[sort:'fieldPosition',order:'asc']).each({
      def hasChildFields=Field.countByParent(it)>0
	  if (hasChildFields && (it.parent!=null) && (it.parent!=it)){
		    out << "<li rel=\"field\" class=\"open field\" id=\"field_${it.id}\"><a class=\"file field\" href=\"#\" id=\"${it.id}\"><ins>&nbsp;</ins>${it.name}</a>\n"
		    out << "<ul>"
			def lattrs = [field:it]
			modelTree.call(lattrs)
			out << "</ul></li>"
		}
		else {
			out << "<li rel=\"field\" class=\"field\" id=\"field_${it.id}\"><a class=\"file field\" href=\"#\" id=\"${it.id}\"><ins>&nbsp;</ins>${it.name}</a></li>\n"
		}
	})
	}
	}
	
	def row = { attrs,body ->
		def object=attrs.object;
		def domainPropertyName=object.getClass().getName()
		def domainClass = new DefaultGrailsDomainClass( object.class )
		domainPropertyName=domainClass.propertyName
		def propertyName=attrs.propertyName;
		def property=domainClass.getPropertyByName(propertyName)
		def naturalName=property.naturalName;

		
		
		out <<"""<tr class="prop object-${domainPropertyName} property-${domainPropertyName}-${propertyName} property-${propertyName}">
				<td valign="top" class="name">
        		<label for="name">${g.message(code:"${domainPropertyName}.${propertyName}.label", default:"${naturalName}")}</label>
        		</td>
        		<td valign="top" class="value null ${hasErrors(bean: domainClass, field: propertyName, 'errors')}">
				"""
		out << body()
		
		out << """&nbsp;
        	<span class="help-icon help action" title="${g.message(code:"${domainPropertyName}.${propertyName}.help",default:'Help!')}" href="#">&nbsp;</span>                
			</td></tr>"""		
	

		

	
	}
	
	
	def textField = { attrs ->
		
		out << row (object:attrs.object,propertyName:attrs.propertyName) {
			
			
			switch(attrs.mode) {			
				case "show":							
					"""${fieldValue(bean: attrs.object, field: attrs.propertyName)}"""
					break
				
				case "edit":			
					"""${g.textField(name:attrs.propertyName,value:attrs.object."${attrs.propertyName}")}"""
					break		
			}
		}
	}
	
	def date = { attrs ->
	
		out << row (object:attrs.object,propertyName:attrs.propertyName) {
			
			
			switch(attrs.mode) {			
				case "show":							
					"""${fieldValue(bean: attrs.object, field: attrs.propertyName)}"""
					break
				
				case "edit":			
					"""${g.textField(name:attrs.propertyName,value:attrs.object."${attrs.propertyName}",class:'datepicker')}"""
					break		
			}
		}
	}
	
	
	def textArea = { attrs ->	
		out << row (object:attrs.object,propertyName:attrs.propertyName) {
			switch(attrs.mode) {			
				case "show":							
					"""${fieldValue(bean: attrs.object, field: attrs.propertyName)}"""
					break
				
				case "edit":			
					"""${g.textArea(name:attrs.propertyName,value:attrs.object."${attrs.propertyName}",cols:40,rows:5)}"""
					break		
			}
		}
	}
	
	def checkBox = { attrs ->
	
		out << row (object:attrs.object,propertyName:attrs.propertyName) {
			switch(attrs.mode) {			
				case "show":							
					"""${fieldValue(bean: attrs.object, field: attrs.propertyName)}"""
					break
				
				case "edit":			
					"""${g.checkBox(name:attrs.propertyName,value:attrs.object."${attrs.propertyName}")}"""
					break		
			}
		}
	}
	
	
	def domainObject = { attrs ->
	
		out << row (object:attrs.object,propertyName:attrs.propertyName) {
			switch(attrs.mode) {			
				case "show":							
					"""${fieldValue(bean: attrs.object, field: attrs.propertyName)}"""
					break
				
				case "edit":
					def optionValues=[]
					def domainClass = new DefaultGrailsDomainClass( attrs.object.class )
					def property=domainClass.getPropertyByName(attrs.propertyName)
					if (attrs.from) {
                    	optionValues=attrs.from
                    } else {
                    	//optionValues= attrs.object."${attrs.propertyName}".class.findAll([sort:'name',order:'asc'])
                    	optionValues= property.getType().findAll([sort:'name',order:'asc'])
                    }
					
					
					
					def value=attrs.object."${attrs.propertyName}"
					def valueId=value ? value.id : null
											
					if (property.isOptional())
						"""${g.select(name:attrs.propertyName+'.id',value:valueId,from:optionValues,optionKey:'id',noSelection:['null': '-'] )}"""
					else
						"""${g.select(name:attrs.propertyName+'.id',value:valueId,from:optionValues,optionKey:'id')}"""
					break		
			}
		}
	}
	
	def select = { attrs ->
	
		out << row (object:attrs.object,propertyName:attrs.propertyName) {
			switch(attrs.mode) {			
				case "show":							
					"""${fieldValue(bean: attrs.object, field: attrs.propertyName)}"""
					break
				
				case "edit":					
					def domainClass = new DefaultGrailsDomainClass( attrs.object.class )
					def property=domainClass.getPropertyByName(attrs.propertyName)
					
                    def cp = domainClass.constrainedProperties[attrs.propertyName]
                                                               
                    def optionValues=[]
                    if (attrs.from) {
                    	optionValues=attrs.from
                    } else {
                    	optionValues=attrs.object.constraints."${attrs.propertyName}".inList
                    }
					
					if (property.isOptional())
						"""${g.select(name:attrs.propertyName+'.id',value:attrs.object."${attrs.propertyName}",from:optionValues,noSelection:['null': '-'] )}"""
					else
						"""${g.select(name:attrs.propertyName+'.id',value:attrs.object."${attrs.propertyName}",from:optionValues)}"""
					break		
			}
		}
	}
	
	
	def tabs = { attrs,body ->
	
		out << """<div id="dialogtabs" > 
			<ul>"""
			def names=attrs.names.split(",")
			for (name in names) {
				out <<"""
				<li>
					<a href="#dialog${name}">${name}</a>
				</li>
				"""
			}
		out <<"""</ul>"""
		out << body()
		out << "</div>"
	}

	def tab = { attrs,body ->
	
	out << """<div id="dialog${attrs.name}">		
			<table ><tbody>"""
		
	out << body()
	out << "</tbody></table></div>"
}

	
	def form = { attrs,body ->
	
		out << """<div id="dialog" title="${attrs.title}">
		<form id="ajaxdialogform">"""
		
		out << body()
		out << "</form></div>"
	}

	def table = { attrs,body ->
	
		out << """<table><tbody>"""	
		out << body()
		out << "</tbody></table>"
}
	
	
}

