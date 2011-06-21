package org.workflow4people.services

import org.apache.commons.lang.WordUtils

class ListService {
	
	def wf4pConfigService
    boolean transactional = true

    def serviceMethod() {

    }
    /*
	def jsonlist(dc,params,request) {
		return jsonlist(dc,params,request, null)
	}
	*/
    def jsonlist(dc,params,request,filterColumnName=null,actions=null) {
        	def title=dc.getName();
        	title=title.replaceAll (".*\\.", "")
        	def propName=title[0].toLowerCase()+title.substring(1)
        	
            def columns=dc.listProperties
            def sortName=columns[new Integer(params.iSortCol_0)]
     		sortName=sortName? sortName:columns[0]
			 
			def documentList
			def iTotalDisplayRecords
			if (filterColumnName && params.sSearch) {
				def filterMethod = "findAllBy"+WordUtils.capitalize(filterColumnName)+"Like"
				iTotalDisplayRecords=dc."$filterMethod"(params.sSearch+"%").size()
				documentList=dc."$filterMethod"(params.sSearch+"%", [max:params.iDisplayLength,offset:params.iDisplayStart,order:params.sSortDir_0,sort:sortName])
			} else {
				documentList=dc.list([max:params.iDisplayLength,offset:params.iDisplayStart,order:params.sSortDir_0,sort:sortName])
				iTotalDisplayRecords = dc.count()
			}

    		def aaData=[]
            documentList.each { doc ->
        		def inLine=[]
        		columns.each { 	            			   
        			//inLine += "${fieldValue(bean: doc, field: it)}"
        			inLine +=doc."${it}".toString()
        		}	            		
        		def baseUrl=request.contextPath
        		if(!actions) {
        			actions= { dok -> """<span class="list-action-button ui-state-default" onclick="formDialog(${dok.id},'${propName}','')">dialog</span>&nbsp;<span class="list-action-button ui-state-default" onclick="deleteDialog(${dok.id},'${propName}','')">delete</span>&nbsp;<a class="list-action-button ui-state-default" href="${baseUrl}/${propName}/show/${dok.id}">show</a>&nbsp;<a class="list-action-button ui-state-default" href="${baseUrl}/${propName}/edit/${dok.id}">edit</a>&nbsp;<a class="list-action-button ui-state-default confirm" href="${baseUrl}/${propName}/delete/${dok.id}" title="Delete this item" >&times;</a>""" }
        		}
        		inLine+=actions(doc)
        		def aaLine=[inLine]
        		aaData+=(aaLine)
    		}

    		def json = [sEcho:params.sEcho,iTotalRecords:dc.count(),iTotalDisplayRecords:iTotalDisplayRecords,aaData:aaData]
        	return json
        }
    
    
}
