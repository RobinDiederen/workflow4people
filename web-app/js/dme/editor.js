/*
 * Data model editor
 * TEST
 */

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
        		$("a.help").cluetip({
        			splitTitle: '|',  
        			cluezIndex: 2000
       	    	});
                      },
         close: function(event, ui) {      
                theDialog.dialog("destroy").remove();
                }
              });
	
		
	
}

function flashMessage(message) {
	$("#status").html(message).fadeIn("slow").fadeOut("slow");
}

function dmeDialog(item,itemName) {
	 var dialogHTML = $.ajax({
		  url: "/workflow4people/dataModelEditor/edit"+itemName+"/"+item.id,
		  async: false
		 }).responseText;
	 var theDialog=$(dialogHTML).dialog({ 
		 modal:true,
		 width:600,
		 height:400,
		 buttons: { 
		 	"Save": function() {
			 	var formData=$("form#ajaxdialogform").serialize();
			 	$.post("/workflow4people/dataModelEditor/submit"+itemName+"/"+item.id,formData, function(data) 
			 		{
			 		
			 		$("#editpane").html(data);
			 		$("#tabs").tabs();
			 	});
			 	
	 			flashMessage(itemName+" "+item.id+" saved");
	
	 			$( this ).dialog( "close" );
	        	},
       	Cancel: function() {
	        		$( this ).dialog( "close" );
	        	}
       	},
        open: function(event, ui) {           	
       		$("#dialogtabs").tabs(); 
       		$("a.help").cluetip({
       			splitTitle: '|',  
       			cluezIndex: 2000
      	    	});
                     },
        close: function(event, ui) {      
               theDialog.dialog("destroy").remove();
               }
             });
	
		
	
}




function setupTree() {
		        //$("a.field").click(function() {        			     
                //	$("#editpane").load("/workflow4people/dataModelEditor/showField/"+this.id,'',function() {
                //	$("#tabs").tabs();                	
                //	});
                $("a.field").click(function() {
                		
                		 var dialogHTML = $.ajax({
                			  url: "/workflow4people/dataModelEditor/showField/"+this.id,
                			  async: false
                			 }).responseText;
                		$(dialogHTML).dialog(
                                { modal:true,
                                    buttons: { "Delete all items": function() {
                                                                           $( this ).dialog( "close" );
                                                     },
                                                       Cancel: function() {
                                                                   $( this ).dialog( "close" );
                                                     }
                                           }
                                   });

                    	
                    	//$("#tabs").tabs();                	
                    	});	
                	
                	
       
        
        $("a.fieldlist").click(function() {     
                	$("#editpane").load("/workflow4people/dataModelEditor/showFieldList/"+this.id,'',function() {
                	$("#tabs").tabs();
                	});
        });
        }
		
$(function() {		        
	/*
	$("#treediv").bind("before.jstree", function (e,data) {
		//move_node
		 if(data.func === "move_node") {
			 flashMessage("Before move...");
		//	 alert("Func:"+data.func+" Args:"+data.args);
		 }
		//return true;
	});
	*/
	
	
/*	
	$("#treediv").bind("prepare_move.jstree", function (e,data) {
		//alert ("Prepping to move...");
		flashMessage("Prepping to move...");
	});
	*/
	
	
	$("#treediv").bind("move_node.jstree", function (e,data) {
		//alert ("We're moving!");
		
		data.rslt.o.each(function (i) {
			var theId=$(this).attr("id").replace("node_","");
			var theParent=data.rslt.np.attr("id").replace("node_","");
			
			var position=data.rslt.p;
			
			flashMessage("We're moving "+theId+" to "+position+" "+data.rslt.cp +" under "+theParent);
			/*$.ajax({
				async : false,
				type: 'POST',
				url: "./server.php",
				data : { 
					"operation" : "move_node", 
					"id" : $(this).attr("id").replace("node_",""), 
					"ref" : data.rslt.np.attr("id").replace("node_",""), 
					"position" : data.rslt.cp + i,
					"title" : data.rslt.name,
					"copy" : data.rslt.cy ? 1 : 0
				},
				success : function (r) {
					if(!r.status) {
						$.jstree.rollback(data.rlbk);
					}
					else {
						$(data.rslt.oc).attr("id", "node_" + r.id);
						if(data.rslt.cy && $(data.rslt.oc).children("UL").length) {
							data.inst.refresh(data.inst._get_parent(data.rslt.oc));
						}
					}
					$("#analyze").click();
				}
			});*/
		});

		
		
		
		//flashMessage("We're moving!");
		
		
		
		
		
		
		
	});
	
	
	
	
        $("#treediv").jstree({
        //	"plugins" : [ "themes", "json_data", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu" ],

        "plugins" : [  "html_data","themes", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu" ],
 /*
       "contextmenu" : {
        	"items" : {
        	
        	  "rename" : {
        		    // The item label
        		    "label"             : "Rename"
        }
           }
        
        	
        
        },	
        
        */
        
        
        
  /*
        
        
        
        "types" : {
        	"types": {	        	
			"default" : {
				clickable	: true,
				renameable	: true,
				deletable	: true,
				creatable	: true,
				draggable	: true,
				max_children	: -1,
				max_depth	: -1,
				valid_children	: "field",
	
					icon : {
						image : false,
						position : false
					}
				},
				
			"field" : {
					"max_children"	: 0,
					"select_node"	: true,
					"open_node"	: true,
					"close_node"	: true,
					"create_node"	: true,
					"delete_node"	: true,
					"valid_children"	: [""],

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
					
				}
				
	        }
				
				, 
				
				
				
		},
		/*
	      "dnd" : {
            "drag_finish" : function () {
                alert("DROP");
            },
			
		
        },
        */
		/*
		callback: {
		
		 		"beforemove" : function(NODE, REF_NODE, TYPE, TREE_OBJ) {
		 			//alert("AAA"+NODE);		 				 			
					var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/beforemove/",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel'),ref_node_id:REF_NODE.id,ref_node_rel:$("#"+REF_NODE.id).attr('rel'),type:TYPE },
	   					//success: function(returnval){   							
	   					//	var rv = eval('(' + returnval + ')').result	  ;   				
	   					//	}
	   						
 					}).responseText;
 					//alert(t);
	 					var rv = eval('(' + t + ')').result	 		;			
			 			return rv.returnValue 
	 			},
	 			
	 			"beforemoveadvice" : function(NODE, REF_NODE, TYPE, TREE_OBJ,is_copy) {
 					//alert("Advice:"+NODE); 			
 					
					var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/beforemoveadvice",
	   					//data: "",
	   					dataType: "json",	   					
	   					//data: {"node_id": NODE.id ,"node_rel":$("#"+NODE.id).attr('rel'),"ref_node_id":REF_NODE.id,"ref_node_rel":$("#"+REF_NODE.id).attr('rel'),"type":TYPE,"tree_obj": ''},
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel'),ref_node_id:REF_NODE.id,ref_node_rel:$("#"+REF_NODE.id).attr('rel'),type:TYPE}, 
   					    //success: function(returnval){
   					    //	alert("test returnval:"+returnval);   							
	   					//	var rv = eval('(' + returnval + ')').result;
						//	alert("test rv:"+rv);
	   					//	}
	   					
	   					
 					}).responseText;
 					
 					//alert("Done AJAX call for advice");
 					var rv = eval('(' + t + ')').result
 					//alert(rv.advice);	 					
		 			return rv.advice
	 			},
	 			
 				"beforedelete" : function(NODE, REF_NODE, TYPE, TREE_OBJ) {		 				 			
					var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/beforedelete",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel') },
	   					//success: function(returnval){   							
	   					//	var rv = eval('(' + returnval + ')').result
	   					//	}
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
		 				flashMessage('Moved node '+NODE.id+' to '+REF_NODE.id);
	 					var rv = eval('(' + t + ')').result	 					
	 			},
		 				
		 		"oncopy" : function(NODE, REF_NODE, TYPE, TREE_OBJ,RB) {		 					 			 
		 			var t=$.ajax({
			 			async: false,
	   					type: "POST",
	   					url: "/workflow4people/dataModelEditor/oncopy",
	   					data: { node_id: NODE.id ,node_rel:$("#"+NODE.id).attr('rel'),ref_node_id:REF_NODE.id,ref_node_rel:$("#"+REF_NODE.id).attr('rel'),type:TYPE }
 					}).responseText;
		 				flashMessage('Copied node '+NODE.id+' to '+REF_NODE.id);
	 					var rv = eval('(' + t + ')').result	 					
		 			// TODO fix _copy id suffix
		 			// TODO correct id for new leaf node
		 			// attach onclick handlers to copied nodes
		 			
	 			}	
	 			
	 			
	 			
	 			
 			}   */     
        });
        
        
        //  Open the show field pane on a single click
        $("a.field").click(function() {        			     
                	$("#editpane").load("/workflow4people/dataModelEditor/showField/"+this.id,'',function() {
                	$("#tabs").tabs();                	
                	});
                	
        });
        
        //  Open the edit field pane on a double click        
        $("a.field").dblclick(function() {
        	//fieldDialog(this)
        	dmeDialog(this,'Field');
        	//$("#editpane").load("/workflow4people/dataModelEditor/editField/"+this.id,'',function() {
        	//$("#tabs").tabs();                	
        	//$("a.help").cluetip({splitTitle: '|'});
        	//});        	
        });
        
        
        //  Open the show fieldlist pane on a single click
        $("a.fieldlist").click(function() {     
                	$("#editpane").load("/workflow4people/dataModelEditor/showFieldList/"+this.id,'',function() {
                	$("#tabs").tabs();
                	});
        });
        
        //  Open the edit fieldlist pane on a double click
        $("a.fieldlist").dblclick(function() {        
        	dmeDialog(this,'FieldList');
                	//$("#editpane").load("/workflow4people/dataModelEditor/editFieldList/"+this.id,'',function() {
                	//$("#tabs").tabs();
                	//$("a.help").cluetip({splitTitle: '|'});
                	//});
        });        
        
        
        $("#outer-treediv").resizable();
        $("#outer-editpane").resizable();

       
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
       				$("a.help").cluetip({splitTitle: '|'});
       			});
       		} else {
       			//alert("Going for the editor for "+id);
       			$("#editpane").load("/workflow4people/dataModelEditor/editField/"+id,'',function() {
       				//alert("Okay, we're in!");	       		
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
     	
     	//alert("Waaaaaaaaaaaaaa");
     	return false;
    	
       });
       
       $("#createFieldListButton").click(function() {
       	//var node=jQuery.tree.focused().create({data: '',attributes: {id:'test'}},-1);
       		//alert(node);
       		//jQuery.tree.focused().rename([node],'aaaaa');
       		//jQuery.tree.focused().create(null,-1);
       		//alert('before');
       		//$.tree.focused().rename();
       		$.jstree.focused().create();
       		//alert('after');
       
       });
       
});