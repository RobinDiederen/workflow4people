<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Document tree</title>
		<r:require modules="wfp,wfp-tree"/>				
    </head>
    <body>    
	    <div class="body">
	    	<div class="editor dialog row " style="position:relative;width:auto;">	    	
		        <%-- Content tree --%>
		        <div id="modelPane" class="treepane span6" >
		        	<div class="xui-widget-header xui-corner-all xui-helper-clearfix">Content</div>		        	
					<div class="tree-toolbar">
						<g:link onclick="dialog.formDialog(null,'document',{ dialogname: 'dialog', submitname: 'submitdialog'}, null);return false;" title="New content at root level" class="action-new-fieldtype action" >&nbsp;</g:link>
					</div>
		        	<div id="contentTree" style="overflow:auto;" class="contentTree" >
		        	<ul id="tree" class="filetree treeview" />    
		        	</div>		            
				</div>				
			</div>
		</div>
    
   
    </body>
</html>
