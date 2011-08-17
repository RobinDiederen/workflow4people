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
package org.workflow4people

/**
 * Mail tag library
 * This library is used while rendering code snippet GSP's 
 *
 * @author Jacques Gehlen
 */

import java.text.*;
class MailTagLib {
	static namespace="mail"
	
	def form = { attrs, body ->
		
		def formHead="""<div>
			<div><span>${attrs.title}</span></div>
			<div>"""
			
    out << formHead
    out << body()

    out << """</div>
      </div>"""
	}

	def output = { attrs, body ->
	  
	  switch (attrs.type) {
		  case "text":				
			  out << attrs.value
		  break
		  case "date":
			  def xsDateformatter = new SimpleDateFormat("yyyy-MM-dd")
			  def dateFormatter = new SimpleDateFormat(g.message(code: 'output.date.format'))
			  def dateValue
			  if (attrs.value.text().length() > 0) {
			    dateValue = xsDateformatter.parse(attrs.value.text())
			  }
			  out << (dateValue ? dateFormatter.format(dateValue) : '')
		  break
		  case "textarea":
			  out << attrs.value
		  break
		}
	}

	def comment = { attrs, body ->
	  
		def formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss")
	  
		def html = ""
		def doc = attrs.document
		doc.header.comments.comment.each { comment ->
			def formattedCommentDate = "unknown"
			if(comment.dateTime) {
				def commentDate = (Date)formatter.parse(comment.dateTime.text())
				formattedCommentDate = commentDate.dateTimeString
			}
		  html += """<div><div>${formattedCommentDate}, ${comment.user.text()}:</div><div>${comment.text.text()}</div></div>"""
		}
		out << html
  }

}
