/*
 * Workflow4people Javascript
 * 
 */

var fieldTypeTree
var dataModelTree
var workflowTree

		
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