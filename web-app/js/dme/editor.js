/*
 * Data model editor
 * 
 */

//var fieldTypeTree
var dataModelTree
var workflowTree

/*
 * Modal JQuery UI confirmation dialog
 */

function jqConfirm(message,title,url) {
	var htmlMessage='<div id="dialog-confirm" title="'+title+'"><p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>'+message+'</p></div>';
	
	var confirmDialog=$(htmlMessage).dialog({
		resizable: true,
		width:600,
		modal: true,
		buttons: {
			"OK": function() {				
				alert(url)
				$( this ).dialog( "close" );
			},
			Cancel: function() {
				$( this ).dialog( "close" );
			}
		},
        close: function(event, ui) {      
            confirmDialog.remove();
            }
        });			
	
}


/*
 * Modal JQuery UI confirmation dialog
 */

function updateProcessDefinition(node) {
	var htmlMessage='<div id="dialog-confirm" title="Update process definition"><p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Update process definition '+node[0].title+' ?<br />This will update the runtime engine process definition for this workflow.</p><p>&nbsp;</p><p id="returnMessage"></p></div>';
	var updDialog=$(htmlMessage).dialog({
		resizable: true,
		width:600,
		modal: true,
		buttons: {
			"Update": function() {				
				var res=$.getJSON("/workflow4people/wf4pProcessDefinition/updateProcess/"+node[0].title, function (json) {
					$("#returnMessage").html(json.result.message);
					if (json.result.returnValue) {
						$("button:contains('Done')").show();
						$("button:contains('Update')").hide();
					    $("button:contains('Cancel')").hide();
					    $("button:contains('Again')").hide();
					} else {
						$("button:contains('Update') span").html("Again");
					}
					
				});
			},
			Cancel: function() {
				$( this ).dialog( "close" );
			},
			
			"Done": function() {
				$( this ).dialog( "close" );
			}
			
		},
		
		open: function(event, ui) {
     		$("button:contains('Done')").hide();
			},
        
		
        close: function(event, ui) {      
            updDialog.remove();
            }
        });			
	
}


function trim(value) {
	  value = value.replace(/^\s+/,'');
	  value = value.replace(/\s+$/,'');
	  return value;
	}


function refreshTree(id) {
	if(id) {
		if (dataModelTree.find("#"+id).size()>0) {
			dataModelTree.jstree("refresh","#"+id)
		}
		
		if (id=="dataModelTree") {
			dataModelTree.jstree("refresh",-1)
		}
				
		if (workflowTree.find("#"+id).size()>0) {
			workflowTree.jstree("refresh","#"+id)
		}
		
		if (id=="workflowTree") {
			workflowTree.jstree("refresh",-1)
		}
		
		
	}
	
	
}

function generateFormsDialog(node) {	
	 var id=node[0].id.substring(9)
	 var dialogHTML = $.ajax({
		  url: "/workflow4people/workflowDefinition/generate/"+id,
		  async: false
		 }).responseText;
	 var dialogHTML2=$(dialogHTML).find("#dialog")
	 var theDialog=$(dialogHTML2).dialog({ 
		 modal:true,
		 width:800,
		 height:500,
		 buttons: { 
		 	"Ok": function() {
	 			$( this ).dialog( "close" );

	        	}
      	},
       open: function(event, ui) {           	
      		$("#dialogtabs").tabs(); 
      		$(".help").cluetip({
      			splitTitle: '|',  
      			cluezIndex: 2000
     	    	});
                    },
       close: function(event, ui) {      
              $("#dialog").stopTime();
              theDialog.dialog("destroy").remove();
              }
            });
	 $("#dialog").everyTime(500,function(i) {
			$.getJSON("/workflow4people/workflowDefinition/progress",
	        function(p){
	          $("#count").html(p.count);
	          $("#total").html(p.total);
	          $("#message").html(p.message);
	          $("#generatelog").html(p.log);
	          $("#progressbar").progressbar({
				value: p.pct
				});
			  if (p.completed) {
			  $("div.title h1").html("Generating forms completed");
			  }
	        });
		});
	
}


function generateProcessDialog(node) {	
	 var id=node[0].id.substring(9)
	 var dialogHTML = $.ajax({
		  url: "/workflow4people/workflowDefinition/generateProcess/"+id,
		  async: false
		 }).responseText;
	 var dialogHTML2=$(dialogHTML).find("#dialog")
	 var theDialog=$(dialogHTML2).dialog({ 
		 modal:true,
		 width:800,
		 height:500,
		 buttons: { 
		 "Start": function() {
		 		$.getJSON("/workflow4people/workflowDefinition/generateProcessStart/"+id);
		 
		 		
		 		
		 $("#dialog").everyTime(500,function(i) {
				$.getJSON("/workflow4people/workflowDefinition/progress",
		        function(p){
		          $("#count").html(p.count);
		          $("#total").html(p.total);
		          $("#message").html(p.message);
		          $("#generatelog").html(p.log);
		          $("#progressbar").progressbar({
					value: p.pct
					});
				  if (p.completed) {
				  $("div.title h1").html("Generating forms completed");
				  $("button:contains('Done')").show();
				  $("button:contains('Cancel')").hide();
				  $("button:contains('Start') span").html("Again");
				  }
		        });
			});
		 
	        	},
    	"Done": function() {
	        		$( this ).dialog( "close" );
	        	},
     	Cancel: function() {
	        		$( this ).dialog( "close" );
	        	}
     	},
      open: function(event, ui) {
     		$("button:contains('Done')").hide();
     		$("#dialogtabs").tabs(); 
     		$(".help").cluetip({
     			splitTitle: '|',  
     			cluezIndex: 2000
    	    	});
                   },
      close: function(event, ui) {      
             $("#dialog").stopTime();
             theDialog.dialog("destroy").remove();
             }
           });

}






function workflowContextMenu( node ) {
	if (node[0].id.substring(0,9)=="workflow_") {
	var obj = {
			
			"editworkflowproperties" : {
								"label": 'Edit workflow props',
								"action" : function( node ) {
						        	var theId = node[0].id.split('_').pop();
						        	formDialog(theId,'dataModelEditor',{ dialogname: "editWorkflowDefinition", submitname: "submitWorkflowDefinition"}, null);
						        }
	  						  },

			
			"editworkflowdiagram" : {
								"label": 'Edit workflow diagram',
								"action" : function( node ) { window.open('http://localhost:8080/signaviocore/p/editor?id=root-directory%3B'+node[0].title+'.jpdl.xml','signavio','width=1000,height=700,left=0,top=100,screenX=0,screenY=100') }
							  },

			"generateforms" : {
								  "label": 'Generate forms',
								  "action" : function( node ) { generateFormsDialog(node); }
							  },
			"generateprocess" : 	  {
								"label": 'Generate process',
								"action" : function( node ) { generateProcessDialog(node) }
								  },
			"updateprocessdef" : 	  {
								"label": 'Update process def',
								"action" : function( node ) { updateProcessDefinition(node) }
	   	    },		  
					  
								  

  		    "newform" : {
								  "label": 'New form',
								  "action" : function( node ) { 
									  var parentId = node[0].id.split('_').pop();
									  formDialog(null,'dataModelEditor',{ dialogname: "editForm", submitname: "submitForm"}, { parentId: parentId });
								  }
							  },
			"delete" : {
									"label": 'Delete',
									"action" : function( node ) {this.remove(node) }
								}
	
	}
	
	
	return obj; 
	} else {
		var obj = {
				

				"delete" : {
										"label": 'Delete',
										"action" : function( node ) {this.remove(node) }
									}
		
		}
		
		
		return obj;		
		
		
	}
		
	
	
	
	
	
	
}
		
$(function() {		        
	$(".dmeTree").bind("before.jstree", function (e,data) {		
		
		if(data.func === "move_node" || data.func === "delete_node" || data.func === "rename_node" ) {
			if(!data.args[0][0]) {
				return 
			}
			
			if (data.func==="delete_node") {
				if (!confirm('Are you sure?')) {
					e.stopImmediatePropagation();
					return false;
					
				}
			}
				
			
			var id1=data.args[0][0].id
			var id2=""
			if (data.func === "move_node") {
				var id2=data.args[1][0].id
			}
			
			var moveType=data.args[2]
			
			var isCopy=data.args[3]
			logMessage("Before "+data.func +" ... from:#"+id1+" to:#"+id2+" moveType:"+moveType+" copy:"+isCopy);
			var newName=""
			if (data.func==="rename_node") {
				newName=data.args[1]
			}
			
			var jsonobj= {
					"func":data.func,
					"id1":id1,
					"id2":id2,
					"moveType":moveType,
					"isCopy":isCopy,
					"newName":newName					
			}
			
			var jsonResponse = $.ajax({
  			  url: "/workflow4people/dataModelEditor/before/1",
  			  async: false,
  			  cache: false,
  			  data: jsonobj,
  			  type: "POST"
  			  
  			 }).responseText;
			var result=eval('(' + jsonResponse + ')').result;
			
			for (i in result.refreshNodes) {
	 			refreshTree(result.refreshNodes[i])
	 		}
			
			if (result.success) {
				logMessage(result.message)
			} else {
				alert(result.message)
			}
		
			if (result.allowed==false) {
				e.stopImmediatePropagation();
				return false;
			}
		
		 }
	});

	
    dataModelTree=$("#modelTree").jstree({
        "plugins" : [  "json_data", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu","themes" ,"hotkeys"],
        
       "crrm" : {
        	"move.always_copy" : "multitree"
        },
 
       "contextmenu" : {        
        	"items": function ( node ) {
        		


            			var obj = {            					
            					"insertField" : {
									"label": 'Insert field ...',
									"action" : function( node ) {
										var nodeType = node[0].id.split("_")[0];
										var parentId = node[0].id.split("_")[1];
										
										nodeType = nodeType.toLowerCase();
				        				if (nodeType=="fieldtype") {
				        					formDialog(null,"dataModelEditor",{ dialogname: "editField", submitname: "submitFieldUnderFieldType"},{ parentId: parentId, parentType: nodeType });
				        				} else {
				        					formDialog(null,"dataModelEditor",{ dialogname: "editField", submitname: "submitField"},{ parentId: parentId });				        					
				        				}
									}
								},
								"delete" : {
            									"label": 'Delete',
            									"action" : function( node ) {this.remove(node) }
            								}
            			}
            			return obj;
            			
            			
            			
        			}        			
        },
        
        "json_data" : {
            "ajax" : {
                "url" : "/workflow4people/dataModelEditor/fieldJSON",
                cache: false,
                "data" : function (n) {
                    return { id : n.attr ? n.attr("id") : "" };
                }
            }
        }
  
        
    
        });
    
    	workflowTree=$("#workflowTree").jstree({         

        "plugins" : [  "json_data","themes", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu","hotkeys" ],
        
        
        "json_data" : {
            "ajax" : {
                "url" : "/workflow4people/dataModelEditor/workflowJSON",
                cache: false,
                "data" : function (n) {
                    return { id : n.attr ? n.attr("id") : "" };
                }
            }
        },
    	
    	 "contextmenu" : {        	
        	"items": workflowContextMenu     			
        }
    	
    	
    	
    	});  
    
    	
//    	################################################
//    	# Double Click Events                          #
//    	################################################
    	
        //  Open the edit field dialog on a double click        
        $("li.field").live("dblclick",function() {
        	var theId = this.id.split('_').pop();
        	formDialog(theId,'dataModelEditor',{ dialogname: "editField", submitname: "submitField"}, null);  
        	return false;
        });
             
        // 	Open the edit fieldtype dialog on a double click
        $("li.fieldtype").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	formDialog(theId,'dataModelEditor',{ dialogname: "editFieldType", submitname: "submitFieldType"}, null);          	
        	return false;
        });

        // 	Open the edit form dialog on a double click
        $("li.form").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	formDialog(theId,'dataModelEditor',{ dialogname: "editForm", submitname: "submitForm"}, null);        	
        	return false;
        });
        
        // 	Open the edit formItem dialog on a double click
        $("li.formitem").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	formDialog(theId,'dataModelEditor',{ dialogname: "editFormItem", submitname: "submitFormItem"}, null);        	
        	return false;
        });

        
        // Open the edit workflowDefinition dialog on a double click
        $("li.workflow").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	formDialog(theId,'dataModelEditor',{ dialogname: "editWorkflowDefinition", submitname: "submitWorkflowDefinition"}, null);
        	return false;
        });
        
       $(".treepane").resizable();
       $(".treepane").draggable();
   
});