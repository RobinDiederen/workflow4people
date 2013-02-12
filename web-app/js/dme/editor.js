/*
 * Data model editor
 * 
 */

//var fieldTypeTree
var dataModelTree
var workflowTree
//var dme = {};
 //dme.clipboard = {};

dme.refreshTreeHandler=function refreshTreeHandler(event,eventData) {
	if (eventData!=null && eventData.jsonResponse !=null && eventData.jsonResponse.refreshNodes !=null ) {
		for (i in eventData.jsonResponse.refreshNodes) {
 			dme.refreshTree(eventData.jsonResponse.refreshNodes[i])
 		}
	}
};


/*
 * Update process definition
 */

dme.updateProcessDefinition = function updateProcessDefinition(node) {
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


dme.trim = function trim(value) {
	  value = value.replace(/^\s+/,'');
	  value = value.replace(/\s+$/,'');
	  return value;
	}


dme.refreshTree = function refreshTree(id) {
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

dme.generateFormsDialog = function generateFormsDialog(node) {	
	 //var id=node[0].id.substring(9)
	 var id=node[0].id
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
      		/*$(".help").cluetip({
      			splitTitle: '|',  
      			cluezIndex: 2000
     	    	});*/
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


dme.generateProcessDialog = function generateProcessDialog(node) {	
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






dme.workflowContextMenu = function workflowContextMenu( node ) {
	var obj ={};
	if (node[0].id.substring(0,9)=="workflow_") {
		obj = {
			
			"editworkflowproperties" : {
								"label": 'Edit workflow props',
								"action" : function( node ) {
						        	var theId = node[0].id.split('_').pop();
						        	dialog.formDialog(theId,'dataModelEditor',{ dialogname: "editWorkflowDefinition", submitname: "submitWorkflowDefinition"}, null);
						        }
	  						  },

			
			"editworkflowdiagram" : {
								"label": 'Edit workflow diagram',
								"action" : function( node ) { window.open(dme.urlSignavio + '?id=root-directory%3B'+node[0].title+'.jpdl.xml','signavio','width=1000,height=700,left=0,top=100,screenX=0,screenY=100') }
							  },

			"generateforms" : {
								  "label": 'Generate model/forms',
								  "action" : function( node ) { dme.generateFormsDialog(node); }
							  },
			"generateprocess" : 	  {
								"label": 'Generate process',
								"action" : function( node ) { dme.generateProcessDialog(node) }
								  },
			"updateprocessdef" : 	  {
								"label": 'Update process def',
								"action" : function( node ) { dme.updateProcessDefinition(node) }
	   	    },		  
					  
								  

  		    "newform" : {
								  "label": 'New form',
								  "action" : function( node ) { 
									  var parentId = node[0].id.split('_').pop();
									  dialog.formDialog(null,'dataModelEditor',{ dialogname: "editForm", submitname: "submitForm"}, { parentId: parentId });
								  }
							  },
			"delete" : {
									"label": 'Delete',
									"action" : function( node ) {this.remove(node) }
								}
	
		}
	}

	if (node[0].id.substring(0,5)=="form_") {
		var pasteLabel=dme.clipboard.title?'Paste '+dme.clipboard.title:'Paste'
		obj = {										
	  		    "newpage" : {
									  "label": 'New page',
									  "action" : function( node ) { 
										  var parentId = node[0].id.split('_').pop();
										  dialog.formDialog(null,'formPage',{ dialogname: "dialog", submitname: "submitdialog"}, { parentId: parentId });}
									  },
			  "paste" : {				  
					"label": pasteLabel,
					"action" : function( node ) {dme.pasteFromClipboard(node) }
					},									  
									  "generateforms" : {
										  "label": 'Generate form',
										  "action" : function( node ) { dme.generateFormsDialog(node); }
									  },
									  
									  
				"delete" : {
											"label": 'Delete',
											"action" : function( node ) {this.remove(node) }
										}			
		}			
					
	}
	
	if (node[0].id.substring(0,9)=="formpage_") {
		obj = {										
	  		    "newsection" : {
									  "label": 'New section',
									  "action" : function( node ) { 
										  var parentId = node[0].id.split('_').pop();
										  dialog.formDialog(null,'formSection',{ dialogname: "dialog", submitname: "submitdialog"}, { parentId: parentId });
									  }
									  },
				"copy" : {
					"label": 'Copy',
					"action" : function( node ) {dme.copyToClipboard(node) }
				},
				
				"paste" : {
					"label": 'Paste',
					"action" : function( node ) {dme.pasteFromClipboard(node) }
				},
									  
									  
				"delete" : {
										"label": 'Delete',
										"action" : function( node ) {this.remove(node) }
							}			
		}			
					
	}
	
	if (node[0].id.substring(0,12)=="formsection_") {
		obj = {										
	  		    "newitem" : {
									  "label": 'New item',
									  "action" : function( node ) { 
										  var parentId = node[0].id.split('_').pop();
										  dialog.formDialog(null,'formItem',{ dialogname: "dialog", submitname: "submitdialog"}, { parentId: parentId });
									  }
									  
									  },
			
				
				"paste" : {
					"label": 'Paste',
					"action" : function( node ) {dme.pasteFromClipboard(node) }
				},					  
									  
				"delete" : {
										"label": 'Delete',
										"action" : function( node ) {this.remove(node) }
							}			
		}			
					
	}
								
	if (node[0].id.substring(0,9)=="formitem_") {
		obj = {		
				"copy" : {
					"label": 'Copy',
					"action" : function( node ) {dme.copyToClipboard(node) }
				},
				
				"paste" : {
					"label": 'Paste',
					"action" : function( node ) {dme.pasteFromClipboard(node) }
				},
				"delete" : {
										"label": 'Delete',
										"action" : function( node ) {this.remove(node) }
							}			
		}			
					
	}
		
	
	
	
	return obj
	
	
}

dme.copyToClipboard= function copyToClipboard(node) {
	dme.clipboard.id=node[0].id;
	dme.clipboard.title=node[0].title
	$(".dialog-events").trigger("dialog-message",{ message: dme.clipboard.title +' ('+dme.clipboard.id+') copied to clipboard' })
}

dme.pasteFromClipboard= function pasteFromClipboard(node) {
	
	var jsonobj= {
			"func":"move_node",
			"id1":dme.clipboard.id,
			"id2":node[0].id,
			"moveType":"inside",
			"isCopy":true,
			"newName":""					
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
			dme.refreshTree(result.refreshNodes[i])
		}
	
	if (result.success) {
		$(".dialog-events").trigger("dialog-message",{ message: result.message })	
	} else {
		alert(result.message)
	}
	
}

		
$(function() {		        
	$(".dmeTree").bind("before.jstree", function (e,data) {		
		
		if(data.func === "move_node" || data.func === "delete_node" || data.func === "rename_node" ) {
			if(!data.args[0][0]) {
				return 
			}
			
			if (data.func==="delete_node") {
				if (!confirm('Are you sure you want to delete "'+data.args[0][0].title+'" ?')) {
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
	 			dme.refreshTree(result.refreshNodes[i])
	 		}
			
			if (result.success) {
				$(".dialog-events").trigger("dialog-message",{ message: result.message })	
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
				        					dialog.formDialog(null,"dataModelEditor",{ dialogname: "editField", submitname: "submitFieldUnderFieldType"},{ parentId: parentId, parentType: nodeType });
				        				} else {
				        					dialog.formDialog(null,"dataModelEditor",{ dialogname: "editField", submitname: "submitField"},{ parentId: parentId });				        					
				        				}
									}
								},
								"copy" : {
									"label": 'Copy',
									"action" : function( node ) {dme.copyToClipboard(node) }
								},
								
								"paste" : {
									"label": 'Paste',
									"action" : function( node ) {dme.pasteFromClipboard(node) }
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
                    return { id : n.attr ? n.attr("id") : dme.modelRoot };
                }
            }
        },
        "themes" : {
            //Really, we don't need to load this again ...
            url: "/workflow4people/css/theme/theme.css"
        }

  
        
    
        });
    
    	workflowTree=$("#workflowTree").jstree({            		
        "plugins" : [  "json_data","themes", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu","hotkeys" ],
        
        
        "json_data" : {
            "ajax" : {
                "url" : "/workflow4people/dataModelEditor/workflowJSON",
                cache: false,
                "data" : function (n) {
                    return { id : n.attr ? n.attr("id") : dme.workflowRoot } ;
                }
            }
        },
    	
    	 "contextmenu" : {        	
        	"items": dme.workflowContextMenu     			
        },
        "themes" : {
            //Really, we don't need to load this again ...
            url: "/workflow4people/css/theme/theme.css"
        }
    	
    	
    	
    	});  
    
    	
//    	################################################
//    	# Double Click Events                          #
//    	################################################
    	
        //  Open the edit field dialog on a double click        
        $("li.field").live("dblclick",function() {
        	var theId = this.id.split('_').pop();
        	dialog.formDialog(theId,'dataModelEditor',{ dialogname: "editField", submitname: "submitField"}, null);  
        	return false;
        });
             
        // 	Open the edit fieldtype dialog on a double click
        $("li.fieldtype").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	dialog.formDialog(theId,'fieldType',{ dialogname: "dialog", submitname: "submitdialog"}, null);          	
        	return false;
        });

        // 	Open the edit form dialog on a double click
        $("li.form").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	dialog.formDialog(theId,'dataModelEditor',{ dialogname: "editForm", submitname: "submitForm"}, null);        	
        	return false;
        });
        
        // 	Open the edit form dialog on a double click
        $("li.formpage").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	dialog.formDialog(theId,'formPage',{ dialogname: "dialog", submitname: "submitdialog"}, null);        	
        	return false;
        });
        
        // Open the edit form dialog on a double click
        $("li.formsection").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	dialog.formDialog(theId,'formSection',{ dialogname: "dialog", submitname: "submitdialog"}, null);        	
        	return false;
        });
        
        // 	Open the edit formItem dialog on a double click
        $("li.formitem").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	dialog.formDialog(theId,'dataModelEditor',{ dialogname: "editFormItem", submitname: "submitFormItem"}, null);        	
        	return false;
        });

        
        // Open the edit workflowDefinition dialog on a double click
        $("li.workflow").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	dialog.formDialog(theId,'dataModelEditor',{ dialogname: "editWorkflowDefinition", submitname: "submitWorkflowDefinition"}, null);
        	return false;
        });
        
       $(".treepane").resizable();
       $(".treepane").draggable();
       
		$(".dmeTree").bind("dialog-refresh",dme.refreshTreeHandler);
		$(".dmeTree").addClass("dialog-events");
});