/*
 * Catviz Content Manager
 * 
 * Copyright 2012-2013, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */

/*
 * Content tree model editor
 * 
 */


/**
 * Refresh the tree or a part of the tree
 * This is called in after a dialog has completed or when a dialog-refresh event is received 
 * @param id The id of the node to refresh, or "contentTree" to refresh the entire tree
 */
wfp.refreshTree = function refreshTree(id) {
	if(id) {
		if (wfp.contentTree.find("#"+id).size()>0) {
			wfp.contentTree.jstree("refresh","#"+id)
		}		
		if (id=="contentTree") {
			wfp.contentTree.jstree("refresh",-1)
		}		
	}	
}

/**
 * The content menu that is shown when the user right-clicks on an element of the tree
 * @param node The node 
 * @returns The menu object
 */
wfp.contentMenu = function contentMenu(node) {
	var obj = {            					
		"new" : {
			"label": 'New document ...',
			"action" : function( node ) {
				var nodeType = node[0].id.split("_")[0];
				var parentId = node[0].id.split("_")[1];						
				nodeType = nodeType.toLowerCase();						
	        	dialog.formDialog(null,'document',{ domainclass : 'Document',dialogname:'dialog'},{ parentId : parentId})
			}
		},
		
		"edit" : {
			"label": 'Edit ...',
			"action" : function( node ) {										
				var id = node[0].id.split("_")[1];										
	        	dialog.formDialog(id,'document',{ domainclass : 'Document',dialogname:'dialog'},{ })										
			}
		},
		
		"copy" : {
			"label": 'Copy',
			"action" : function( node ) {wfp.copyToClipboard(node) }
		},
		
		"paste" : {			
			"label": wfp.clipboard.title?'Paste "'+wfp.clipboard.title+'"':'Paste' ,
			"action" : function( node ) {wfp.pasteFromClipboard(node) }
		},
		

		"delete" : {
						"label": 'Delete',
						"action" : function( node ) {
							var id = node[0].id.split("_")[1];			
							dialog.deleteDialog(id,'document',{ domainclass : 'Document'});
							//this.remove(node);
						}
					}
	}
	return obj;		
}    

/**
 * Refresh the tree (in response to a dialog-refresh event)
 * @param event
 * @param eventData
 */

wfp.contentTreeRefreshEvent = function statusMessage(event,eventData) {
	if (eventData.jsonResponse) {
		if (eventData.jsonResponse.refreshNodes) {
			for (i in eventData.jsonResponse.refreshNodes) {
	 			wfp.refreshTree(eventData.jsonResponse.refreshNodes[i])
	 		}
		}
	}
}

/**
 * Handle events in the content tree. All events are caught before they would have effect on the tree and all are blocked from the tree's perspective so we have full control over what happens
 * @param e
 * @param data
 * @returns {Boolean}
 */
wfp.beforeJstree=function beforeJstree(e,data)  {		
	
	if(data.func === "move_node" || data.func === "delete_node" || data.func === "rename_node" ) {
		if(!data.args[0][0]) {
			return 
		}
		
		if (data.func==="delete_node") {
			if (!confirm('Are you sure you want to delete '+data.args[0][0].title+' ?')) {
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
			  url: "/workflow4people/document/before/1",
			  async: false,
			  cache: false,
			  data: jsonobj,
			  type: "POST"
			  
			 }).responseText;
		var result=eval('(' + jsonResponse + ')').result;
		
		for (i in result.refreshNodes) {
 			wfp.refreshTree(result.refreshNodes[i])
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
}

/**
 * Clipboard
 * 
 */
wfp.clipboard = {}

/**
 * Copy node to clipboard
 * Both the ID and title are stored. This allows us to show the clipboard item title in the context menu
 * @param 
 */
wfp.copyToClipboard= function copyToClipboard(node) {
	wfp.clipboard.id=node[0].id;
	wfp.clipboard.title=node[0].title
	$(".dialog-events").trigger("dialog-message",{ message: wfp.clipboard.title +' ('+wfp.clipboard.id+') copied to clipboard' })
}

/**
 * Paste item from clipboard (copy action)
 * @param node
 */
wfp.pasteFromClipboard= function pasteFromClipboard(node) {
	
	var jsonobj= {
			"func":"move_node",
			"id1":wfp.clipboard.id,
			"id2":node[0].id,
			"moveType":"inside",
			"isCopy":true,
			"newName":""					
	}
	
	var jsonResponse = $.ajax({
		  url: "/workflow4people/document/before/1",
		  async: false,
		  cache: false,
		  data: jsonobj,
		  type: "POST"
		  
		 }).responseText;
	var result=eval('(' + jsonResponse + ')').result;
	
	for (i in result.refreshNodes) {
			wfp.refreshTree(result.refreshNodes[i])
		}
	
	if (result.success) {
		$(".dialog-events").trigger("dialog-message",{ message: result.message })	
	} else {
		alert(result.message)
	}
	
}



/**
 * Initialize the tree
 */

		
$(function() {		        
	$(".contentTree").bind("before.jstree", wfp.beforeJstree);
	
	wfp.contentTree=$("#contentTree").jstree({
		"plugins" : [  "json_data", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu","themes" ,"hotkeys"],
		"crrm" : {
			"move.always_copy" : "multitree"
		},		
       "contextmenu" : {
    	   "items": wfp.contentMenu ,

       },       
       "json_data" : {
    	   "ajax" : {
    		   "url" : "/workflow4people/document/contentJSON",
    		   cache: false,
    		   "data" : function (n) {
    			   return { id : n.attr ? n.attr("id") : "" };
    		   }
    	   }
       },
       "themes" : {
    	   //Really, we don't need to load this again ...
    	   url: "/workflow4people/css/theme/theme.css"
       }   
	});
    
	//  Open the edit field dialog on a double click        
	$("li.document").live("dblclick",function() {
		var theId = this.id.split('_').pop();        	
			dialog.formDialog(theId,'document',{ domainclass : 'Document'})
			return false;
	});

	// Bind event handlers
   	$("#contentTree").bind("dialog-refresh",wfp.contentTreeRefreshEvent);	
   	$("#contentTree").addClass("dialog-events");
});