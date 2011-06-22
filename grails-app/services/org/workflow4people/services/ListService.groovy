package org.workflow4people.services

import org.apache.commons.lang.WordUtils

class ListService {
	
	def wf4pConfigService
	def grailsApplication
    boolean transactional = true

    def serviceMethod() {

    }
    
	// complete
	def jsonlist(dc,params,request) {
		return jsonlist(dc,params,request, null)
	}
	
	// with filter
    def jsonlist(dc,params,request, filterColumnName) {
        	def title=dc.getName();
        	title=title.replaceAll (".*\\.", "")
        	def propName=title[0].toLowerCase()+title.substring(1)
        	
            def columns=dc.listProperties
            def sortName=columns[new Integer(params.iSortCol_0)]
     		sortName=sortName? sortName:columns[0]
			 
			def documentList
			def iTotalRecords=dc.count()
			def iTotalDisplayRecords
			
			//Create Id for the table
			def detailTableId="detailTable_"+dc
			detailTableId=detailTableId.replace(".","_")
			detailTableId=detailTableId.replace("class ","")
						
			if (params['objectId'] != null) {
				if (params.objectId !='null') {
					def filterMethod = "findAllBy"+WordUtils.capitalize(params.property)
					def masterDomainObj = grailsApplication.getClassForName(params.objectClass).get(params.objectId)
					documentList=dc."$filterMethod"(masterDomainObj, [max:params.iDisplayLength,offset:params.iDisplayStart,order:params.sSortDir_0,sort:sortName])
					iTotalRecords=documentList.size()
					iTotalDisplayRecords = iTotalRecords
				} else {
					iTotalRecords=0
					iTotalDisplayRecords=0
				}				
			} else {
				if (filterColumnName && params.sSearch) {
					def filterMethod = "findAllBy"+WordUtils.capitalize(filterColumnName)+"Like"
					iTotalDisplayRecords=dc."$filterMethod"(params.sSearch+"%").size()
					documentList=dc."$filterMethod"(params.sSearch+"%", [max:params.iDisplayLength,offset:params.iDisplayStart,order:params.sSortDir_0,sort:sortName])
				} else {
					documentList=dc.list([max:params.iDisplayLength,offset:params.iDisplayStart,order:params.sSortDir_0,sort:sortName])
					iTotalDisplayRecords = iTotalRecords
				}
			}
			
    		def aaData=[]
            documentList.each { doc ->
        		def inLine=[]
        		columns.each { 	            			   
        			inLine +=doc."${it}".toString()
        		}	            		
        		def baseUrl=request.contextPath
        		//inLine+="""<span class="list-action-button ui-state-default" onclick="formDialog(${doc.id},'${propName}',{ refresh : '${detailTableId}'})">dialog</span>&nbsp;<span class="list-action-button ui-state-default" onclick="deleteDialog(${doc.id},'${propName}',{ refresh : '${detailTableId}'})">delete</span>&nbsp;<a class="list-action-button ui-state-default" href="${baseUrl}/${propName}/show/${doc.id}">show</a>&nbsp;<a class="list-action-button ui-state-default" href="${baseUrl}/${propName}/edit/${doc.id}">edit</a>&nbsp;<a class="list-action-button ui-state-default confirm" href="${baseUrl}/${propName}/delete/${doc.id}" title="Delete this item" >&times;</a>"""
				inLine+="""<span class="list-action-button ui-state-default" onclick="formDialog(${doc.id},'${propName}',{ refresh : '${detailTableId}'})">edit</span>&nbsp;<span class="list-action-button ui-state-default" onclick="deleteDialog(${doc.id},'${propName}',{ refresh : '${detailTableId}'})">&times;</span>"""
				def aaLine=[inLine]
        		aaData+=(aaLine)
    		}

    		def json = [sEcho:params.sEcho,iTotalRecords:iTotalRecords,iTotalDisplayRecords:iTotalDisplayRecords,aaData:aaData]
        	return json
        }
    
    
}
