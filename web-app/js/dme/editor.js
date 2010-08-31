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
		
$(function() {		        
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
        //  Open the show field pane on a single click
        $("a.field").click(function() {        			     
                	$("#editpane").load("/workflow4people/dataModelEditor/showField/"+this.id,'',function() {
                	$("#tabs").tabs();                	
                	});
                	
        });
        
        //  Open the edit field pane on a double click        
        $("a.field").dblclick(function() {        			     
        	$("#editpane").load("/workflow4people/dataModelEditor/editField/"+this.id,'',function() {
        	$("#tabs").tabs();                	
        	$("a.help").cluetip({splitTitle: '|'});
        	});        	
        });
        
        
        //  Open the show fieldlist pane on a single click
        $("a.fieldlist").click(function() {     
                	$("#editpane").load("/workflow4people/dataModelEditor/showFieldList/"+this.id,'',function() {
                	$("#tabs").tabs();
                	});
        });
        
        //  Open the edit fieldlist pane on a double click
        $("a.fieldlist").dblclick(function() {             		
                	$("#editpane").load("/workflow4people/dataModelEditor/editFieldList/"+this.id,'',function() {
                	$("#tabs").tabs();
                	$("a.help").cluetip({splitTitle: '|'});
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
       		$.tree.focused().create();
       		//alert('after');
       
       });
       
});