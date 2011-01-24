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
class WformTagLib {
	
	static namespace = 'wform'
		
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
	
	
}

