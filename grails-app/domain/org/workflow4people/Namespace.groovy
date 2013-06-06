/*
 * Workflow4people
 * Copyright 2009-2013, Open-T B.V., and individual contributors as indicated
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
package org.workflow4people
import org.open_t.dialog.*

/**
 * Namespace domain class. 
 * Represents a namespace. Each namespace, both generated and imported, need to be defined here.
 * 
 * @author Joost Horward
 */
class Namespace {
	static listConfig=new ListConfig(name:'namespace',controller: 'namespace',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'prefix',sortable:true,filter:true
		column name:'uri',sortable:true,filter:true
		column name:'filename',sortable:true,filter:true
		column name:'generateXSDFile',sortable:true,filter:true
		column name:'includeSchema',sortable:true,filter:true
		column name:'importSchema',sortable:true,filter:true
	}
	
	static hasMany = [importSchema:Namespace]

	static constraints = {    	
		includeSchema(nullable:true)
		importSchema(nullable:true)
	}
	
	String prefix
	String uri

	String filename
	String includeSchema

	boolean generateXSDFile=true

	def getTargetNamespaceDeclaration(){		
		return "targetNamespace=\"${this.uri}\"\n"
	}

	def getPrefixDeclarations() {		
		def decl="xmlns:${this.prefix}=\"${this.uri}\"\n";
		importSchema.each({
			decl+="xmlns:${it.prefix}=\"${it.uri}\"\n";
		});		
		return(decl)
	}

	String toString() {
		return prefix;
	}
}