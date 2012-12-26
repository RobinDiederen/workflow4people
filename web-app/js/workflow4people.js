/*
 * Workflow4people Javascript
 * 
 */

var fieldTypeTree
var dataModelTree
var workflowTree

//var dataTableHashList = {}

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


function trim(value) {
	  value = value.replace(/^\s+/,'');
	  value = value.replace(/\s+$/,'');
	  return value;
	}



function logMessage(message) {
		var oldmessage=$("#log").html();
	$("#log").html(oldmessage+'<br />'+message);
	
}

function formDialog(id,controllerName, options ,urlParams) {
	var urlId=id+obj2ParamStr(urlParams);
	
	var dialogName = (options != null && options["dialogname"] != null) ? options["dialogname"] : "dialog";
	var submitName = (options != null && options["submitname"] != null) ? options["submitname"] : "submitdialog";
	var refreshTableKey = (options != null && options["refresh"] != null) ? options["refresh"] : "NO_REFRESH";
			 
	 theUrl=wfp.baseUrl+'/'+controllerName+'/'+dialogName+'/'+urlId	 	
	 
	 var dialogHTML = $.ajax({
		  url: theUrl,
		  async: false,
		  cache: false
		 }).responseText;
	 
	 var formelements=$(dialogHTML).find('form')
	 if (formelements.length==0) {
		 window.location.reload()
	 } else {
	 
	 var theWidth=$(dialogHTML).css("width");
	 
	 var theDialog=$(dialogHTML).dialog({ 
		 modal:true,
		 width:theWidth,
		 buttons: { 
		 	"Save": function(e) {
			 	var formData=theDialog.find("form").serialize();
			 	$.post(wfp.baseUrl+"/"+controllerName+"/"+submitName+"/"+urlId,formData, function(data) 
			 		{
			 		var jsonResponse = data.result;

			 		$("#statusmessage").html(jsonResponse.message);

			 		//DME logMessage & refreshTree (editor.js)
			 		if (typeof(refreshTree) === 'function') {
				 		for (i in jsonResponse.refreshNodes) {
				 			refreshTree(jsonResponse.refreshNodes[i]);
				 		}
			 		}
			 		if (typeof(logMessage) === 'function') {
			 			logMessage(jsonResponse.message);			 			
			 		}

			 		refreshDataTable(refreshTableKey, dataTableHashList, (id ? false : true));
			 		
			 		if(jsonResponse.success){
				 		theDialog.dialog("close");
				 	} else  {
				 		for (key in jsonResponse.errorFields) {
				 			var errorField=jsonResponse.errorFields[key]
				 			$("#"+errorField).parent().addClass("errors")				 			
				 		}
				 		theDialog.find("div.errors").html(jsonResponse.message)
				 		theDialog.find("div.errors").show();				 		
				 	}			 		
			 	});			 	
        	},
       	Cancel: function() {
	        		$( this ).dialog( "close" );
	        	}
       	},
        open: function(event, ui) { 
         	// Initialize date picker input elements
       		$(this).find(".datepicker").datepicker({ dateFormat: "yy-mm-dd" , changeMonth: true, changeYear:true});
       		$(this).find(".dialogtabs").tabs();
       		$(this).find(".altselect").altselect();
       		
       		var dataTable = $(this).find('.detailTable');
       		
       		$(this).find('.detailTable').each(function (index) {
       			var curMatch = $(this);
       			var tableId = curMatch.attr('id');
       			var jsonUrl = curMatch.attr("jsonUrl");
       			var controller = jsonUrl.split('/')[1]; //extract controller name from json url
       			
       			dataTableHashList[tableId] = curMatch.dataTable({
    				"bProcessing": true,
    				"bServerSide": true,
    				"sAjaxSource": wfp.baseUrl+jsonUrl,
    				"sPaginationType": "full_numbers",
    				"bFilter": false,
    				"bJQueryUI": true
    			});
       			
       			// Add NEW button ("parent()" is the div with class dataTables_wrapper)
       			if (id != null) {
       				curMatch.parent().find('div.dataTables_length').prepend('<span class="list-toolbar-button ui-widget-content ui-state-default"><span onclick="formDialog(null,\''+controller+'\', { refresh : \''+tableId+'\'}, { parentId : '+id+'})">New</span></span>&nbsp;');
       			}
       			
       		});
       		
       		$(this).find(".help").cluetip({
       			splitTitle: '|',  
       			cluezIndex: 2000
      	    	});
                     },
        close: function(event, ui) {      
               theDialog.dialog("destroy").remove();
             }
         });
	 
	 }
}


function deleteDialog(id,controllerName, options ,urlParams) {
	var urlId=id+obj2ParamStr(urlParams);
	 
	 var dialogHTML = '<div "title="Confirm delete"><form><div class="errors" style="display:none;"></div><div>Are you sure you want to delete '+controllerName+' '+id+' ?</div></form></div>'	 
	 
	 var theDialog=$(dialogHTML).dialog({ 
		 modal:false,
		 width:400,
		 height:100,
		 buttons: { 
		 	"Delete": function(e) {
			 	var formData=theDialog.find("form").serialize();
			 	$.post(wfp.baseUrl+"/"+controllerName+"/delete/"+urlId,formData, function(data) 
			 		{
			 		var result=data.result			 		
			 		$("#statusmessage").html(result.message);
			 		
			 		refreshDataTable(options["refresh"], dataTableHashList, false);
			 		
			 		if(result.success){
				 		theDialog.dialog("close");
				 	} else  {				 		
				 		theDialog.find("div.errors").html(result.message)
				 		theDialog.find("div.errors").show();				 		
				 	}			 		
			 	});			 	
       	},
      	Cancel: function() {
	        		$( this ).dialog( "close" );
	        	}
      	},
       close: function(event, ui) {      
              theDialog.dialog("destroy").remove();
            }
        });
}

function refreshDataTable(key, list, lastPage) {
	var curTable = list[key];
	if (typeof(curTable) !== 'undefined' && curTable != null) {
		if (lastPage == false) {
			curTable.fnDraw(false);
		} else {
			curTable.fnPageChange( 'last' );
		}
		
	}
}

function obj2ParamStr(params) {
	var paramStr="";
	 if (params) {
		 var sep = "?";
		 for (key in params) {
			 paramStr=paramStr+sep+key+"="+params[key];
			 sep="&";
		 }		 
	 }
	 return paramStr;
}
		
$(function() {		        

	/* Helper for the left menu, when clicking a li the enclosed a's href  will be called */
	$("div.wf4p-menu ul ul li a").each(function (index) {
		var curMatch = $(this);
		curMatch.parent().click(function(){
			document.location = curMatch[0].href;
		});
	});
	
	/* Hide jBpm menu if not used	*/
	var pathName = window.location.pathname;
	if (pathName.split('/')[2].substring(0, 4) == "wf4p") {
		$("#jbpmMenuItems").toggleClass("hideElement");
	}
	$("#jbpmMenu").click(function(){
		$("#jbpmMenuItems").toggleClass("hideElement");
	});
	          	
 	/* Initialize date picker input elements */
 	$(".datepicker").datepicker({ dateFormat: "yyyy-MM-dd'T'HH:mm:ss" , changeMonth: true, changeYear:true});
  	
  	$("a.confirm").live("click",function(){
  	return confirm('Are you sure?')
  	});
  	
	//$(".help").cluetip({splitTitle: '|'});
	
	/* Sortable lists */
	$(".sortable").sortable({
	 deactivate: function(event, ui) { 			  
	   var positions =ui.sender.sortable('toArray');			   			   
	   $.post("/workflow4people/"+this.id+"/sort",{'positions':positions})
	   }
	
	});
	
	
	
       
});