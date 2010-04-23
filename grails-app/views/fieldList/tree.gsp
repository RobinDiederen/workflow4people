<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>FieldList &quot;${fieldListInstance.name}&quot;</title>
        <g:javascript library="jquery"/>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.treeview.css')}" />        
        <jq:plugin name="treeview"/>
        <script src="/workflow4people/js/jquery/treeview/lib/jquery.cookie.js" type="text/javascript"></script>
        <script type="text/javascript" src="/workflow4people/js/jquery/treeview/jquery.treeview.js"></script>
		        
        <jq:jquery>
                $("#tree").treeview();
                $("span.field,span.fieldlist").click(function() {     
                	$("#editpane").load("/workflow4people/field/ajaxshow/"+this.id);
       	            $("#addfield").attr("href","/workflow4people/field/insert/"+this.id);
                	
					/*                	                	           	
                	$.getJSON("/workflow4people/field/json/"+this.id, function (data) {
                		$("#addfield").attr("href","/workflow4people/field/insert/"+this.id);                	
  
                		});*/
                });
        </jq:jquery>
    </head>
    <body>
    <div class="body">
    	<div class="flash">
    	    <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
    	</div>
    
    
        <div class="nav">            
            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldList" action="show" id="${fieldListInstance.id}" >Show as form</g:link></span>
            <span class="menuButton"><g:link class="awesome small blue button" action="create">New FieldList&nbsp;+</g:link></span>
            
            <span class="menuButton"><a class="awesome small blue button" id="addfield" href="/workflow4people/field/insert?fieldList.id=${fieldListInstance.id}">Insert Field&nbsp;+</a></span>
            
        </div>
               
            <div class="dialog" style="float:left;width:400px;">           
            	<ul id="tree" class="filetree treeview">
            	<li><span id="${fieldListInstance.id}" class="folder toplevelfieldlist">${fieldListInstance.name}</span>
            	<ul>
            	<wform:treeList fieldList="${fieldListInstance}" ></wform:treeList>
            	</ul>
            	</li>
            	</ul> 
            </div>
            <div id="editpane" style="float:right;width:500px;">
            Select a field on the left to show the field details in this pane.
            </div>

        </div>
    </body>
</html>
