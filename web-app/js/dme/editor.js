/*
 * Data model editor
 * 
 */

var fieldTypeTree
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
		//height:140,
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
	//node[0].title+'.jpdl.xml'
	var updDialog=$(htmlMessage).dialog({
		resizable: true,
		width:600,
		//height:140,
		modal: true,
		buttons: {
			"Update": function() {				
			//alert ("test");
				var res=$.getJSON("/workflow4people/wf4pProcessDefinition/updateProcess/"+node[0].title, function (json) {
					//alert(json.message);
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
				
				//$("button:contains('Done')").show();
				//$("button:contains('Update')").hide();
			//	$("button:contains('Cancel')").hide();
				//$( this ).dialog( "close" );
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
		if (fieldTypeTree.find("#"+id).size()>0) { 
			fieldTypeTree.jstree("refresh","#"+id)
		}
		if (id=="fieldTypeTree") {
			fieldTypeTree.jstree("refresh",-1)
		}
		
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
function fieldDialog(field) {
	 var dialogHTML = $.ajax({
		  url: "/workflow4people/dataModelEditor/editField/"+field.id,
		  async: false
		 }).responseText;
	 var theDialog=$(dialogHTML).dialog({ 
		 modal:true,
		 width:600,
		 height:400,
		 buttons: { 
		 	"Save": function() {
			 	var formData=$("form#ajaxdialogform").serialize();
			 	$.post("/workflow4people/dataModelEditor/submitField/"+field.id,formData);
		 		$("#editpane").load("/workflow4people/dataModelEditor/showField/"+this.id,'');
	 			$("#status").html("saved").fadeIn("slow").fadeOut("slow");
	
	 			$( this ).dialog( "close" );
	        	},
        	Cancel: function() {
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
                theDialog.dialog("destroy").remove();
                }
              });
	
		
	
}

function logMessage(message) {
		var oldmessage=$("#log").html();
	$("#log").html(oldmessage+'<br />'+message);
	
}

function dmeDialog(id,itemName,params) {
	 var urlId=""
	 if(params) {
		 urlId=id+'?'+params
	 } else {
		 urlId=id
	 }
	 
	 var dialogHTML = $.ajax({
		  url: wfp.baseUrl+"/dataModelEditor/edit"+itemName+"/"+urlId,
		  async: false
		 }).responseText;
	 
	 var formelements=$(dialogHTML).find('form')
	 if (formelements.length==0) {
		 window.location.reload()
	 } else {
	 
	 var theWidth=$(dialogHTML).css("width");
	 
	 var theDialog=$(dialogHTML).dialog({ 
		 modal:false,

		 width:theWidth,
		 //height:400,
		 buttons: { 
		 	"Save": function() {
			 	//var formData=$("form#ajaxdialogform").serialize();
			 	var formData=theDialog.find("form").serialize();
			 	$.post(wfp.baseUrl+"/dataModelEditor/submit"+itemName+"/"+urlId,formData, function(data) 
			 		{

			 		var result=data.result
			 		logMessage(result.message);

			 		for (i in result.refreshNodes) {
			 			refreshTree(result.refreshNodes[i])
			 		}
			 	});
			 	

	
	 			$( this ).dialog( "close" );
	        	},
       	Cancel: function() {
	        		$( this ).dialog( "close" );
	        	}
       	},
        open: function(event, ui) { 
       		$(this).find(".dialogtabs").tabs();
       		$(this).find('.detailTable').dataTable({"bJQueryUI": true ,"sPaginationType": "full_numbers" });
       		$(this).find(".help").cluetip({
       			splitTitle: '|',  
       			cluezIndex: 2000
      	    	});
                     },
        close: function(event, ui) {      
               theDialog.dialog("destroy").remove();
               //theDialog.remove();
               }
             });
	
		
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
		 modal:false,
		 //zIndex:1500,
		 width:800,
		 height:500,
		 buttons: { 
		 	"Ok": function() {
	 			$( this ).dialog( "close" );
	        	},
      	Cancel: function() {
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
              //theDialog.remove();
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
		 modal:false,
		 //zIndex:1500,
		 width:800,
		 height:500,
		 buttons: { 
		 "Start": function() {
	 			//$( this ).dialog( "close" );
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
             //theDialog.remove();
             }
           });
	 /*
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
	*/
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

							  
							  
			
			/*"deletejq" : 	  {
							"label": 'Delete JQ',
							"action" : function( node ) { jqConfirm("Do you really want to delete "+trim(node[0].textContent)+" ?","Delete","/workflow4people/dataModelEditorController/deleteNode/"+node[0].id); }
							  },*/
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
			//var moveType=e.handleObj.type
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
			
			//var jsonobj2=JSON.stringify(data.args);
			//alert(jsonobj2);
			
			
			var jsonResponse = $.ajax({
  			  url: "/workflow4people/dataModelEditor/before/1",
  			  async: false,
  			  data: jsonobj,
  			  type: "POST"
  			  
  			 }).responseText;
			var result=eval('(' + jsonResponse + ')').result;
		//	alert (result.message)
			//alert (result.allowed)

			
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
			//fieldTypeTree.jstree("refresh",-1)
			//dataModelTree.jstree("refresh",-1)
		
			
			// just a test :D
		//	e.stopImmediatePropagation();
		//	return false;			
		 }
	});
	/*
	$("#modelTree").bind("move_node.jstree", function (e,data) {
		//alert ("We're moving!");
		
		data.rslt.o.each(function (i) {
		var isCopy=(data.rslt.cy==true)
			var theId=$(this).attr("id").replace("node_","");
			var theParent=data.rslt.np.attr("id").replace("node_","");
			
			var position=data.rslt.p;
			if (isCopy) {
				logMessage("["+i+"] copying "+theId+" to "+position+" "+data.rslt.cp +" under "+theParent);
			} else {
				logMessage("["+i+"] moving "+theId+" to "+position+" "+data.rslt.cp +" under "+theParent);
			}
			
			
		});		
	});
	
	$("#modelTree").bind("delete_node.jstree", function (e,data) {
		var id=data.rslt.obj[0].id;
		logMessage("Deleting... "+id);
		$.post("/workflow4people/dataModelEditor/delete/"+id);
		
	});
	
	$("#modelTree").bind("create_node.jstree", function (e,data) {		
		logMessage("Creating... "+data.rslt.obj[0].id);				
	});
	
	
	$("#modelTree").bind("rename_node.jstree", function (e,data) {

		logMessage("Renaming... "+data.rslt.obj[0].id+" - new name:"+data.rslt.name);
		data.rslt.obj[0].id="field_XXX"
	});
	*/
		
    dataModelTree=$("#modelTree").jstree({
        //	"plugins" : [ "themes", "json_data", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu" ],

        "plugins" : [  "json_data", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu","themes" ,"hotkeys"],
        
       "crrm" : {
        	"move.always_copy" : "multitree"
        },
 
       "contextmenu" : {        
        	"items": function ( node ) {
        		


            			var obj = {            					
            					"insertField" : {
									"label": 'Insert field ...',
									//node.id.split("_").pop()
									"action" : function( node ) { 
										//alert (node[0].id.split("_").pop())
				        				if (node[0].id.substring(0,10)=="fieldtype_") {
				        					formDialog(null,"field",{submitname:'submitUnderFieldType'},{parentId:node[0].id.split("_").pop() })
				        				} else {
				        					formDialog(null,"field",null,{parentId:node[0].id.split("_").pop() })
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
                "data" : function (n) {
                    return { id : n.attr ? n.attr("id") : "" };
                }
            }
        },
    	
    	 "contextmenu" : {        	
        	"items": workflowContextMenu     			
        }
    	
    	
    	
    	});  
    
        fieldTypeTree=$("#fieldTypeTree").jstree({         

            "plugins" : [  "json_data","themes", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu" ],
            
            "json_data" : {
	            "ajax" : {
	                "url" : "/workflow4people/dataModelEditor/fieldTypeJSON",
	                "data" : function (n) {
	                    return { id : n.attr ? n.attr("id") : "" };
	                }
	            }
	        }
            
            
        });
        
        
        
        
        
        
        
        
        
        //  Open the show field pane on a single click
        /*
        $("a.field").click(function() {        			     
                	$("#editpane").load("/workflow4people/dataModelEditor/showField/"+this.id,'',function() {
                	$("#tabs").tabs();                	
                	});
                	
        });
        */
        
        //  Open the edit field dialog on a double click        
        $("li.field").live("dblclick",function() {
        	dmeDialog(this.id,'Field','');
        	return false;
        });
               
        //  Open the edit fieldlist dialog on a double click
        $("li.fieldlist").live("dblclick",function() {        
        	dmeDialog(this.id,'FieldList','');
        	return false;
        });
        
        // 	Open the edit fieldtype dialog on a double click
        $("li.fieldtype").live("dblclick",function() {        
        	dmeDialog(this.id,'FieldType','');       
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
        	dmeDialog(this.id,'FormItem','');
        	return false;
        });

        
        // Open the edit workflowDefinition dialog on a double click
        $("li.workflow").live("dblclick",function() {        
        	var theId = this.id.split('_').pop();
        	formDialog(theId,'dataModelEditor',{ dialogname: "editWorkflowDefinition", submitname: "submitWorkflowDefinition"}, null);
        	return false;
        });
        
     
      //   $("#outer-treediv").resizable();
      //  $("#outer-editpane").resizable();
       $(".treepane").resizable();
       $(".treepane").draggable();

       /*
       $("#editButton").click(function() {
        //var id=$("#id").html();
        var id=$("#detailId").attr("value");
        var detailClass=$("#detailClass").attr("value");
        var detailType=$("#detailType").attr("value");
        var theInput
        if (detailType=="edit") {
        	var inputs=$("input");
        	for (theInput in inputs) {
        		alert(theInput.name+':'+theInput.value);
        	}
        	$.post("/workflow4people/dataModelEditor/submit")
        	this.innerHTML="edit";
       	} else {
       		this.innerHTML="save";
      	}
        
        if(detailClass=="Field") {
        	//alert("About to get the editor!");
        	if (detailType=="edit") {
        	//alert("Going for the display!");
       			$("#editpane").load("/workflow4people/dataModelEditor/showField/"+id,'',function() {
       				$("#tabs").tabs();
       				$(".help").cluetip({splitTitle: '|'});
       			});
       		} else {
       			//alert("Going for the editor for "+id);
       			$("#editpane").load("/workflow4people/dataModelEditor/editField/"+id,'',function() {
       				//alert("Okay, we're in!");	       		
       				$("#tabs").tabs();
       				$(".help").cluetip({splitTitle: '|'});
       			});
       		}
     	}
     	
     	if(detailClass=="FieldList") {
       		$("#editpane").load("/workflow4people/dataModelEditor/editFieldList/"+id,'',function() {
       			$("#tabs").tabs();
       			$(".help").cluetip({splitTitle: '|'});
       		});
     	}
     	
     	return false;
    	
       });
       */
       
});