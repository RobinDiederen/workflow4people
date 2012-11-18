<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Data model editor</title>
  		<r:script>
			wfp = {};
		   	wfp.dme = {};
        	wfp.dme.urlSignavio = "${urlSignavio}";
        </r:script>
		<r:require modules="dme" />
				
    </head>
    <body>
	    <div class="body">
	    	<div class="editor dialog" style="position:relative;width:auto;">
	    	
		        <%-- Data model tree --%>
		        <div id="modelPane" class="treepane ui-widget ui-widget-content ui-corner-all" style="position:relative;width:30%;border:1px solid #DDD;float:left;background-color:white;overflow:hidden;">
		        	<div class="ui-widget-header ui-corner-all ui-helper-clearfix">Data model</div>
		        	<div class="tree-toolbar">
						<g:link onclick="formDialog(null,'dataModelEditor',{ dialogname: 'editFieldType', submitname: 'submitFieldType'}, null);return false;" title="New fieldtype" class="action-new-fieldtype action" >&nbsp;</g:link>
					</div>
		        	<div id="modelTree" style="overflow:auto;" class="dmeTree" >
		        	<ul id="tree" class="filetree treeview" />    
		        	</div>		            
				</div>
				
				<%-- workflow tree --%>	
				<div id="workflowPane" class="treepane ui-widget ui-widget-content ui-corner-all" style="position:relative;width:30%;border:1px solid #DDD;float:left;background-color:white;overflow:hidden;">
					<div class="ui-widget-header ui-corner-all ui-helper-clearfix">Workflows</div>
					<div class="tree-toolbar">
						<g:link onclick="formDialog(null,'dataModelEditor',{ dialogname: 'editWorkflowDefinition', submitname: 'submitWorkflowDefinition'}, null);return false;" title="New workflow definition" class="action-new-workflowdefinition action" >&nbsp;</g:link>
					</div>
					<div id="workflowTree" style="overflow:auto;" class="dmeTree" >
						<ul id="workflowList" class="filetree treeview" />
					</div>				
				</div>
			
				<%-- logging pane --%>	
				<div id="loggingPane" class="treepane ui-widget ui-widget-content ui-corner-all ui-helper-clearfix" style="position:relative;width:30%;border:1px solid #DDD;float:left;background-color:white;overflow:hidden;">
					<div class="ui-widget-header">Log</div>   
		            <div id="log" style="overflow:auto;">...</div>
				</div>			
			
			</div>
			
		</div>
        
    </body>
</html>
