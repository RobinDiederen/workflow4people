package org.workflow4people

class ListConfig {
	String name
	String controller 
	Boolean bFilter=false
	def toolbar=false
	def rowreordering=false
	def idName="id"
	List<ListConfigColumn> columns=new ArrayList()
	
	def configure (Closure closure) {
		closure.setDelegate(this)
		closure.setResolveStrategy(Closure.DELEGATE_FIRST)
		closure()
		return this
	}
	
	class ListConfigColumn {
		String name
		Boolean sortable
	}
	
	def column (params){
		columns.add (new ListConfigColumn(params))
	}
	
	def actions=['dialog':'edit','delete':'&times;']
	
	
	def renderActions = { props ->  
		def s="""<div class="btn-group">"""
		actions.each { action,label ->
			switch(action) {
				case "delete":
					s+="""<span class="btn btn-small" onclick="dialog.deleteDialog('${props.itemId}','${props.propName}',{ refresh : '${props.detailTableId}'}, null)">${label}</span>"""
				break
				
				default:					
					s+="""<span class="btn btn-small" onclick="dialog.formDialog('${props.itemId}','${this.controller}',{ dialogname:'${action}',refresh : '${props.detailTableId}'}, null)">${label}</span>"""
			}
			
		
		}
		s+="""</div>"""
		return s
	}
	
	def renderList(datalist,totalRecords,params) {
		def aaData=[]
		datalist.each { item ->
			def row=[:]
			def col=0
			this.columns.each { column ->
				row.put(col,item."${column.name}")
				col++
			}
			//def detailTableId="detailTable_${this.name}"
			//def propName="activitiProcessController"
			//def itemId=item."${idName}"
			def props=[detailTableId:"detailTable_${this.name}",propName:controller,itemId:item."${idName}"]
			//renderActions.detailTableId=detailTableId
			//renderActions.propName=propName
			//renderActions.itemId=itemId
			
			def actionsString=renderActions(props)
			
							
			row.put(col,actionsString)
			aaData+=row
		}
		
		def json = [sEcho:params.sEcho,iTotalRecords:totalRecords,iTotalDisplayRecords:totalRecords,aaData:aaData]
		return json
	}
	
	
}
