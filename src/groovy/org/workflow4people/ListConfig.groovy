package org.workflow4people

class ListConfig {
	String name
	String controller 
	Boolean bFilter=false
	def toolbar=false
	def rowreordering=false
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
	
	def renderList(datalist,totalRecords,params) {
		def aaData=[]
		datalist.each { item ->
			def row=[:]
			def col=0
			this.columns.each { column ->
				row.put(col,item."${column.name}")
				col++
			}
			def detailTableId="detailTable_${this.name}"
			def propName="activitiProcessController"
			def actions="""<div class="btn-group"><span class="btn btn-small" onclick="dialog.formDialog(${item.id},'${this.controller}',{ refresh : '${detailTableId}'}, null)">edit</span><span class="btn btn-small" onclick="dialog.deleteDialog('${item.id}','${propName}',{ refresh : '${detailTableId}'}, null)">&times;</span></div>"""
			row.put(col,actions)
			aaData+=row
		}
		
		def json = [sEcho:params.sEcho,iTotalRecords:totalRecords,iTotalDisplayRecords:totalRecords,aaData:aaData]
		return json
	}
	
	
}
