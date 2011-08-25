<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Data model editor</title>
                
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.treeview.css',contextPath:pluginContextPath)}" />
        <link rel="stylesheet" href="${createLinkTo(dir:'css/dme',file:'jquery.jstree.css',contextPath:pluginContextPath)}" />        
        <link rel="stylesheet" href="${createLinkTo(dir:'css/dme',file:'editor.css',contextPath:pluginContextPath)}" />
        
		<g:javascript src="jquery/jquery.cookie.js" contextPath="${pluginContextPath}" />
		<g:javascript src="jquery/jquery.hotkeys.js" contextPath="${pluginContextPath}" />	
		<g:javascript src="jquery/jquery.jstree.js" contextPath="${pluginContextPath}" />
		<g:javascript src="dme/editor.js" contextPath="${pluginContextPath}" />
				
    </head>
    <body>
	    <div class="body">
	    	<div class="editor dialog" style="position:relative;width:auto;">
	    	
	    		<%-- fieldType tree --%>		
				<div id="fieldTypePane" class="treepane ui-widget ui-widget-content ui-corner-all" style="position:relative;width:30%;float:left;border:1px solid #DDD;hheight:300px;overflow:hidden;background-color:white;">
		    		<div class="ui-widget-header ui-corner-all ui-helper-clearfix">FieldTypes</div>
		    	   	<div class="tree-toolbar">
						<g:link onclick="dmeDialog('','FieldType','');return false;" title="New fieldtype" class="action-new-fieldtype action" >&nbsp;</g:link>
					</div>
					<div id="fieldTypeTree" style="overflow:auto;" class="dmeTree" >
						<ul id="fieldTypeList" class="filetree treeview" />
					</div>				
				</div>
	    	
	    		    	
		        <%-- Data model tree --%>
		        <div id="modelPane" class="treepane ui-widget ui-widget-content ui-corner-all" style="position:relative;width:30%;;border:1px solid #DDD;float:left;overflow:hidden;background-color:white;">
		        	<div class="ui-widget-header ui-corner-all ui-helper-clearfix">Data model</div>
		        	<div class="tree-toolbar">
						<g:link onclick="dmeDialog('','FieldList','');return false;" title="New fieldlist" class="action-new-fieldlist action" >&nbsp;</g:link>
					</div>
		        	<div id="modelTree" style="overflow:auto;" class="dmeTree" >
		        	<ul id="tree" class="filetree treeview">    
		        	</ul>
		        	</div>		            
				</div>
				
				<%-- workflow tree --%>	
				<div id="workflowPane" class="treepane ui-widget ui-widget-content ui-corner-all" style="position:relative;width:30%;;border:1px solid #DDD;float:left;background-color:white;overflow:hidden;">
					<div class="ui-widget-header ui-corner-all ui-helper-clearfix">Workflows</div>
					<div class="tree-toolbar">
						<g:link onclick="dmeDialog('','WorkflowDefinition','');return false;" title="New workflow definition" class="action-new-workflowdefinition action" >&nbsp;</g:link>
<%--						<g:link onclick="formDialog(null,'workflowDefinition',null, null);return false;" title="New workflow definition" class="action-new-workflowdefinition action" >&nbsp;</g:link>--%>
					</div>
					<div id="workflowTree" style="overflow:auto;" class="dmeTree" >
						<ul id="workflowList" class="filetree treeview" />
					</div>				
				</div>
			
				<%-- logging pane --%>	
				<div id="loggingPane" class="treepane ui-widget ui-widget-content ui-corner-all ui-helper-clearfix" style="position:relative;width:30%;;border:1px solid #DDD;float:left;background-color:white;overflow:hidden;">
					<div class="ui-widget-header">Log</div>   
		            <div id="log" style="overflow:auto;">...</div>
				</div>			
			
			</div>
			
		</div>
        
    </body>
</html>
