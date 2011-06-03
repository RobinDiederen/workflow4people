/*
 * Workflow4people Javascript
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
	 var urlId=""
	 if(params) {
		 urlId=id+'?'+params
	 } else {
		 urlId=id
	 }
	 
	 var dialogHTML = $.ajax({
		  url: wfp.baseUrl+'/'+controllerName+'/dialog/'+urlId,
		  async: false
		 }).responseText;
	 
	 var theWidth=$(dialogHTML).css("width");
	 var theDialog=$(dialogHTML).dialog({ 
		 modal:false,
		 width:theWidth,
		 //height:400,
		 buttons: { 
		 	"Save": function(e) {
			 	var formData=theDialog.find("form").serialize();
			 	$.post(wfp.baseUrl+"/"+controllerName+"/submitdialog/"+urlId,formData, function(data) 
			 		{
			 		var result=data.result			 		
			 		$("#statusmessage").html(result.message);
			 		listDatatable.fnDraw(false);
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
		
$(function() {		        

       
});