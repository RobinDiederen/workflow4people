<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Data model editor</title>
  		<script>
			var dme = {};
        	dme.urlSignavio = "${urlSignavio}";
 			dme.clipboard = {};
 			dme.modelRoot="${modelRoot}";
 			dme.workflowRoot="${workflowRoot}";
        </script>
		<r:require modules="dme" />
				
    </head>
    <body>
	    <div class="body">
	    	<div class="editor dialog row " style="position:relative;width:auto;">
	    	
		        <%-- Data model tree --%>
		        <div id="modelPane" class="treepane span6" >
		        	<div class="xui-widget-header xui-corner-all xui-helper-clearfix">Data model</div>
		        	<div class="tree-toolbar">
						<a href="#" onclick="dialog.formDialog(null,'fieldType',{ dialogname: 'dialog', submitname: 'submitdialog'}, null);return false;" title="New fieldtype" class="action-new-fieldtype action" >&nbsp;</a>
					</div>
		        	<div id="modelTree" style="overflow:auto;" class="dmeTree" >
		        	<ul id="tree" class="filetree treeview" />    
		        	</div>		            
				</div>
				
				<%-- workflow tree --%>	
				<div id="workflowPane" class="treepane span6" >
					<div class="">Workflows</div>
					<div class="tree-toolbar">
						<a href="#" onclick="dialog.formDialog(null,'dataModelEditor',{ dialogname: 'editWorkflowDefinition', submitname: 'submitWorkflowDefinition'}, null);return false;" title="New workflow definition" class="action-new-workflowdefinition action" >&nbsp;</a>
					</div>
					<div id="workflowTree" style="overflow:auto;" class="dmeTree" >
						<ul id="workflowList" class="filetree treeview" />
					</div>				
				</div>
			</div>
			<%-- logging pane 
			<div class="row">
					
				<div id="loggingPane" class="treepane span12" >
					<div class="">Log</div>   
		            <div id="log" style="overflow:auto;">...</div>
				</div>			
			
			</div>
			--%>
			
		</div>
        
    </body>
</html>
