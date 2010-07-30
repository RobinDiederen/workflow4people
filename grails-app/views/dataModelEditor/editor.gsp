<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Data model editor</title>
        
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.treeview.css')}" />
        
    <%--    <g:javascript library="jquery"/> --%>
                
<g:javascript src="jquery/jquery-ui-1.8.custom.min.js" />
		<script type="text/javascript" src="/workflow4people/js/jquery/jquery.tree.js"></script>     
		<g:javascript src="jquery/jquery.cluetip.js" />
		
		<script type="text/javascript">
		function setupTree() {
		        $("a.field").click(function() {        			     
                	$("#editpane").load("/workflow4people/dataModelEditor/showField/"+this.id,'',function() {
                	$("#tabs").tabs();                	
                	});
                	
        });
        
        $("a.fieldlist").click(function() {     
                	$("#editpane").load("/workflow4people/dataModelEditor/showFieldList/"+this.id,'',function() {
                	$("#tabs").tabs();
                	});
        });
        }
        </script>
		
		        
        <jq:jquery>
        $("#treediv").tree({
        
        types : {
			"default" : {
				clickable	: true,
				renameable	: true,
				deletable	: true,
				creatable	: true,
				draggable	: true,
				max_children	: -1,
				max_depth	: -1,
				valid_children	: "all",
	
					icon : {
						image : false,
						position : false
					}
				},
				
			"field" : {
				clickable	: true,
				renameable	: true,
				deletable	: true,
				creatable	: false,
				draggable	: true,
				max_children	: -1,
				max_depth	: -1,
				valid_children	: {},
	
					icon : {
						image : false,
						position : "-16px 0px"
					}
				},
				
				
				
		},
		
		callback: {
		
		 		"beforemove" : function(NODE, REF_NODE, TYPE, TREE_OBJ) {		 				 			
					var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/beforemove/",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel'),ref_node_id:REF_NODE.id,ref_node_rel:$("#"+REF_NODE.id).attr('rel'),type:TYPE,tree_obj:TREE_OBJ },
	   					success: function(returnval){   							
	   						var rv = eval('(' + returnval + ')').result	     				
	   						}
 					}).responseText;
	 					var rv = eval('(' + t + ')').result	 					
			 			return rv.returnValue 
	 			},
	 			
	 			"beforemoveadvice" : function(NODE, REF_NODE, TYPE, TREE_OBJ,is_copy) {		 				 			
					var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/beforemoveadvice",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel'),ref_node_id:REF_NODE.id,ref_node_rel:$("#"+REF_NODE.id).attr('rel'),type:TYPE,tree_obj:TREE_OBJ }	   					
 					}).responseText;
 					var rv = eval('(' + t + ')').result	 					
		 			return rv.advice
	 			},
	 			
 				"beforedelete" : function(NODE, REF_NODE, TYPE, TREE_OBJ) {		 				 			
					var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/beforedelete",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel') },
	   					success: function(returnval){   							
	   						var rv = eval('(' + returnval + ')').result
	   						}
 					}).responseText;
	 					var rv = eval('(' + t + ')').result	 					
			 			return rv.returnValue 
	 			},
	 			
 				"onmove" : function(NODE, REF_NODE, TYPE, TREE_OBJ,RB) {
		 				 			 
		 			//alert ('onmove node :'+NODE.id+'\nref node:'+REF_NODE.id+'\nType:'+TYPE);		 			
		 			var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/onmove",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel'),ref_node_id:REF_NODE.id,ref_node_rel:$("#"+REF_NODE.id).attr('rel'),type:TYPE }
 					}).responseText;
	 					var rv = eval('(' + t + ')').result	 					
	 			},
		 				
		 		"oncopy" : function(NODE, REF_NODE, TYPE, TREE_OBJ,RB) {		 					 			 
		 			var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/oncopy",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel'),ref_node_id:REF_NODE.id,ref_node_rel:$("#"+REF_NODE.id).attr('rel'),type:TYPE }
 					}).responseText;
	 					var rv = eval('(' + t + ')').result	 					
		 			// TODO fix _copy id suffix
		 			// TODO correct id for new leaf node
		 			// attach onclick handlers to copied nodes
		 			
	 			}	
	 			
	 			
	 			
	 			
 			}        
        });
        
        $("a.field").click(function() {        			     
                	$("#editpane").load("/workflow4people/dataModelEditor/showField/"+this.id,'',function() {
                	$("#tabs").tabs();                	
                	});
                	
        });
        
        $("a.fieldlist").click(function() {     
                	$("#editpane").load("/workflow4people/dataModelEditor/showFieldList/"+this.id,'',function() {
                	$("#tabs").tabs();
                	});
        });
        
        
        
        
        $("#outer-treediv").resizable();
        $("#outer-editpane").resizable();

       
       $("#editButton").click(function() {
        //var id=$("#id").html();
        var id=$("#detailId").attr("value");
        var detailClass=$("#detailClass").attr("value");
        var detailType=$("#detailType").attr("value");
        
        if (detailType=="edit") {
        	this.innerHTML="edit";
       	} else {
       		this.innerHTML="save";
      	}
        
        if(detailClass=="Field") {
        	if (detailType=="edit") {
       			$("#editpane").load("/workflow4people/dataModelEditor/showField/"+id,'',function() {
       				$("#tabs").tabs();
       				$("a.help").cluetip({splitTitle: '|'});
       			});
       		} else {
       			$("#editpane").load("/workflow4people/dataModelEditor/editField/"+id,'',function() {       		
       				$("#tabs").tabs();
       				$("a.help").cluetip({splitTitle: '|'});
       			});
       		}
     	}
     	
     	if(detailClass=="FieldList") {
       		$("#editpane").load("/workflow4people/dataModelEditor/editFieldList/"+id,'',function() {
       			$("#tabs").tabs();
       			$("a.help").cluetip({splitTitle: '|'});
       		});
     	}
     	
     	
    	
       });
       
       $("#createFieldListButton").click(function() {
       	//var node=jQuery.tree.focused().create({data: '',attributes: {id:'test'}},-1);
       		//alert(node);
       		//jQuery.tree.focused().rename([node],'aaaaa');
       		//jQuery.tree.focused().create(null,-1);
       		//alert('before');
       		//$.tree.focused().rename();
       		$.tree.focused().create();
       		//alert('after');
       
       });
       
       
        </jq:jquery>

              <style type="text/css">/* TREE LAYOUT */ .tree ul { margin:0 0 0 5px; padding:0 0 0 0; list-style-type:none; } .tree li { display:block; min-height:18px; line-height:18px; padding:0 0 0 15px; margin:0 0 0 0; /* Background fix */ clear:both; } .tree li ul { display:none; } .tree li a, .tree li span { display:inline-block;line-height:16px;height:16px;color:black;white-space:nowrap;text-decoration:none;padding:1px 4px 1px 4px;margin:0; } .tree li a:focus { outline: none; } .tree li a input, .tree li span input { margin:0;padding:0 0;display:inline-block;height:12px !important;border:1px solid white;background:white;font-size:10px;font-family:Verdana; } .tree li a input:not([class="xxx"]), .tree li span input:not([class="xxx"]) { padding:1px 0; } /* FOR DOTS */ .tree .ltr li.last { float:left; } .tree > ul li.last { overflow:visible; } /* OPEN OR CLOSE */ .tree li.open ul { display:block; } .tree li.closed ul { display:none !important; } /* FOR DRAGGING */ #jstree-dragged { position:absolute; top:-10px; left:-10px; margin:0; padding:0; } #jstree-dragged ul ul ul { display:none; } #jstree-marker { padding:0; margin:0; line-height:5px; font-size:1px; overflow:hidden; height:5px; position:absolute; left:-45px; top:-30px; z-index:1000; background-color:transparent; background-repeat:no-repeat; display:none; } #jstree-marker.marker { width:45px; background-position:-32px top; } #jstree-marker.marker_plus { width:5px; background-position:right top; } /* BACKGROUND DOTS */ .tree li li { overflow:hidden; } .tree > .ltr > li { display:table; } /* ICONS */ .tree ul ins { display:inline-block; text-decoration:none; width:16px; height:16px; } .tree .ltr ins { margin:0 4px 0 0px; } 
              
              .field a { font-weight: normal; }
              .file a { font-weight: normal; }
              
              </style>
        
    </head>
    <body>
    <div class="body">
    	<div class="flash">
    	    <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
    	</div>
    	<g:formRemote name="editor" update="editpane" url="[action:'submit']">
    
        <div class="nav" style="padding-left:5px;width:805px;clear:both;">            
            <span><a id="editButton" href="" class="awesome small blue button" >edit</a></span>
            <span><a id="createFieldButton" href="" class="awesome small blue button" >create field</a></span>
            <span><a id="createFieldListButton" href="" class="awesome small blue button" >create field list</a></span>
<%--            <span><input value="test" type="button" onclick="$.tree.focused().create();return false" id="testButton" class="awesome small blue button" />test</span> --%>
        </div>
            <div id="outer-treediv" style="float:left;width:400px;height:500px;border:1px solid #DDD;">   
            <div id="treediv" class="dialog" style="float:left;width:95%;height:95%;overflow:auto;">           
            	<ul id="tree" class="filetree treeview">
            	
            	<g:each in="${org.workflow4people.FieldList.findAll([sort:'name'])}" var="fieldListInstance" >
            	
            	<li id="fieldlist_${fieldListInstance.id}" rel="rootFieldList" class="field"><a class="fieldlist" id="${fieldListInstance.id}" href="#"><ins>&nbsp;</ins>${fieldListInstance.name}</a>
            	<ul>
            	<wform:modelTree fieldList="${fieldListInstance}" ></wform:modelTree>
            	</ul>
            	</li>
            	</g:each>
            	
            	</ul> 
            </div>
            </div>
            <div id="outer-editpane" style="float:left;width:400px;height:500px;border:1px solid #DDD;margin-left:5px;">
            <div id="editpane" style="float:left;width:95%;height:95%;overflow:auto;">
            		
            
            Select a field on the left to show the field details in this pane.
            </div>
            </div>
		</g:formRemote>
        </div>
        
    </body>
</html>
