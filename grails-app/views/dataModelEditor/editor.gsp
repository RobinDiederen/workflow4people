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
				<div id="fieldTypePane" class="treepane body ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" style="position:relative;width:30%;float:left;border:1px solid #DDD;hheight:300px;overflow:hidden;background-color:white;">
		    	<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">FieldTypes</div>
		    	   	<div class="tree-toolbar">
						<g:link onclick="dmeDialog('','FieldType','');return false;" title="New fieldtype" class="action-new-fieldtype action" >&nbsp;</g:link>
					</div>
		    	
					<div id="fieldTypeTree" style="overflow:auto;" class="dmeTree ui-dialog-content ui-widget-content" >
						<ul id="fieldTypeList" class="filetree treeview" />
					</div>				
				</div>
	    	
	    		    	
		        <%-- Data model tree --%>
		        <div id="modelPane" style="position:relative;width:30%;;border:1px solid #DDD;float:left;overflow:hidden;background-color:white;" class="treepane body ui-dialog ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
		        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">Data model</div>
		        	<div class="tree-toolbar">
						<g:link onclick="dmeDialog('','FieldList','');return false;" title="New fieldlist" class="action-new-fieldlist action" >&nbsp;</g:link>
					</div>
		        	<div id="modelTree" style="overflow:auto;" class="dmeTree ui-dialog-content ui-widget-content" >
		        	<ul id="tree" class="filetree treeview">    
		        	</ul>
		        	</div>		            
				</div>
				
				
				<%-- workflow tree --%>	

				
				<div id="workflowPane" style="position:relative;width:30%;;border:1px solid #DDD;float:left;background-color:white;overflow:hidden;" class="treepane body ui-dialog ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
				<div style="font-size:12px;" class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">Workflows</div>
				<div class="tree-toolbar">
					<g:link onclick="dmeDialog('','WorkflowDefinition','');return false;" title="New workflow definition" class="action-new-workflowdefinition action" >&nbsp;</g:link>
				</div>
					<div id="workflowTree" style="overflow:auto;" class="dmeTree ui-dialog-content ui-widget-content" >
					<ul id="workflowList" class="filetree treeview" />
					</div>				
				</div>
			
				<%-- logging pane --%>	
				<div id="loggingPane" style="position:relative;width:30%;;border:1px solid #DDD;float:left;background-color:white;overflow:hidden;" class="treepane body ui-dialog ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
					<div style="font-size:12px;" class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">Log</div>   
		            <div id="log" style="overflow:auto;" class="ui-dialog-content ui-widget-content">...</div>
				</div>
			
			
			</div>
			
		</div>
        
    </body>
</html>
