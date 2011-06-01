<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>FieldList &quot;${fieldListInstance.name}&quot;</title>
       <%-- <g:javascript library="jquery"/> --%>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.treeview.css')}" />        
        <%-- <jq:plugin name="treeview"/>
        <script src="/workflow4people/js/jquery/treeview/lib/jquery.cookie.js" type="text/javascript"></script>
        <script type="text/javascript" src="/workflow4people/js/jquery/treeview/jquery.treeview.js"></script>
		     --%>
		<script type="text/javascript" src="/workflow4people/js/jquery/jquery.tree.js"></script>     
		        
        <jq:jquery>
        
        $("#treediv").tree();
        
        $("a.field,a.fieldlist").click(function() {     
        	$("#editpane").load("/workflow4people/field/ajaxshow/"+this.id);
       	    $("#addfield").attr("href","/workflow4people/field/insert/"+this.id);
        });
        
        
        /*
                $("#tree").treeview();
                $("span.field,span.fieldlist").click(function() {     
                	$("#editpane").load("/workflow4people/field/ajaxshow/"+this.id);
       	            $("#addfield").attr("href","/workflow4people/field/insert/"+this.id);
                	
					/*                	                	           	
                	$.getJSON("/workflow4people/field/json/"+this.id, function (data) {
                		$("#addfield").attr("href","/workflow4people/field/insert/"+this.id);                	
  
                		});
                });
                */
        </jq:jquery>
              <style type="text/css">/* TREE LAYOUT */ .tree ul { margin:0 0 0 5px; padding:0 0 0 0; list-style-type:none; } .tree li { display:block; min-height:18px; line-height:18px; padding:0 0 0 15px; margin:0 0 0 0; /* Background fix */ clear:both; } .tree li ul { display:none; } .tree li a, .tree li span { display:inline-block;line-height:16px;height:16px;color:black;white-space:nowrap;text-decoration:none;padding:1px 4px 1px 4px;margin:0; } .tree li a:focus { outline: none; } .tree li a input, .tree li span input { margin:0;padding:0 0;display:inline-block;height:12px !important;border:1px solid white;background:white;font-size:10px;font-family:Verdana; } .tree li a input:not([class="xxx"]), .tree li span input:not([class="xxx"]) { padding:1px 0; } /* FOR DOTS */ .tree .ltr li.last { float:left; } .tree > ul li.last { overflow:visible; } /* OPEN OR CLOSE */ .tree li.open ul { display:block; } .tree li.closed ul { display:none !important; } /* FOR DRAGGING */ #jstree-dragged { position:absolute; top:-10px; left:-10px; margin:0; padding:0; } #jstree-dragged ul ul ul { display:none; } #jstree-marker { padding:0; margin:0; line-height:5px; font-size:1px; overflow:hidden; height:5px; position:absolute; left:-45px; top:-30px; z-index:1000; background-color:transparent; background-repeat:no-repeat; display:none; } #jstree-marker.marker { width:45px; background-position:-32px top; } #jstree-marker.marker_plus { width:5px; background-position:right top; } /* BACKGROUND DOTS */ .tree li li { overflow:hidden; } .tree > .ltr > li { display:table; } /* ICONS */ .tree ul ins { display:inline-block; text-decoration:none; width:16px; height:16px; } .tree .ltr ins { margin:0 4px 0 0px; } 
              
              .field a { font-weight: normal; }
              .file a { font-weight: normal; }
              
              </style>
        
    </head>
    <body>
    <g:link action="show" id="${fieldListInstance.id}" >Show as form</g:link>
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
               
            <div id="treediv" class="dialog" style="float:left;width:400px;">           
            	<ul id="tree" class="filetree treeview">
            	<li><span id="${fieldListInstance.id}" class="folder toplevelfieldlist">${fieldListInstance.name}</span>
            	<ul>
            	<wf:tree fieldList="${fieldListInstance}" ></wf:tree>
            	</ul>
            	</li>
            	</ul> 
            </div>
            <div id="editpane" style="float:right;width:400px;">
            Select a field on the left to show the field details in this pane.
            </div>

        </div>
    </body>
</html>
