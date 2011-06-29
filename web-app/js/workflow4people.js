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

function formDialog(id,controllerName,params) {
	var urlId=id+obj2ParamStr(params);
	 
	 theUrl=wfp.baseUrl+'/'+controllerName+'/dialog/'+urlId	 	
	 
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
			 	$.post(wfp.baseUrl+"/"+controllerName+"/submitdialog/"+urlId,formData, function(data) 
			 		{
			 		var result=data.result			 		
			 		$("#statusmessage").html(result.message);
			 		
			 		refreshDataTable(params["refresh"], dataTableHashList, (id ? false : true));
			 		
			 		if(result.success){
				 		theDialog.dialog("close");
				 	} else  {
				 		for (key in result.errorFields) {
				 			var errorField=result.errorFields[key]
				 			$("#"+errorField).parent().addClass("errors")				 			
				 		}
				 		theDialog.find("div.errors").html(result.message)
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
       		$(this).find(".multiselect").multiselect();
     		
       		var dataTable = $(this).find('.detailTable');
       		if (dataTable.size() > 0) {
       			var tableId = dataTable.attr('id');
       			var jsonUrl = $(this).find('.detailTable').attr("jsonUrl");
       			dataTableHashList[tableId] = dataTable.dataTable({
    				"bProcessing": true,
    				"bServerSide": true,
    				"sAjaxSource": wfp.baseUrl+jsonUrl,
    				"sPaginationType": "full_numbers",
    				"bFilter": false,
    				"bJQueryUI": true
    			});
       		
       			$(this).find('div.dataTables_length').prepend('<span class="list-toolbar-button ui-widget-content ui-state-default"><span onclick="formDialog(null,\'fieldTypeItem\', { refresh : \''+tableId+'\', parentId : '+id+'})">New</span></span>&nbsp;');

       		}

       		
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


function deleteDialog(id,controllerName,params) {
	var urlId=id+obj2ParamStr(params);
	 
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
			 		
			 		refreshDataTable(params["refresh"], dataTableHashList, false);
			 		
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

       
});