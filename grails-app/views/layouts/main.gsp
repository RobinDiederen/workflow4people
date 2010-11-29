<html>
    <head>
    	<!-- This is main.gsp in wfp-meander -->
        <title><g:layoutTitle default="workflow4people" /></title>
        <%-- Standard Grails scaffolding style--%>
        
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css',contextPath:'',plugin:'wfp')}" />
        
        <%-- Workflow4people style --%>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'workflow4people.css',contextPath:'',plugin:'wfp')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css/redmond',file:'jquery-ui-1.8.6.custom.css',contextPath:'',plugin:'wfp')}" />        
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'ui.multiselect.css',contextPath:'',plugin:'wfp')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'awesome-buttons.css',contextPath:'',plugin:'wfp')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'jquery.cluetip.css',contextPath:'',plugin:'wfp')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'js/jquery/themes/default',file:'style.css',contextPath:'',plugin:'wfp')}" />
        <style type="text/css">/* TREE LAYOUT */ .tree ul { margin:0 0 0 5px; padding:0 0 0 0; list-style-type:none; } .tree li { display:block; min-height:18px; line-height:18px; padding:0 0 0 15px; margin:0 0 0 0; /* Background fix */ clear:both; } .tree li ul { display:none; } .tree li a, .tree li span { display:inline-block;line-height:16px;height:16px;color:black;white-space:nowrap;text-decoration:none;padding:1px 4px 1px 4px;margin:0; } .tree li a:focus { outline: none; } .tree li a input, .tree li span input { margin:0;padding:0 0;display:inline-block;height:12px !important;border:1px solid white;background:white;font-size:10px;font-family:Verdana; } .tree li a input:not([class="xxx"]), .tree li span input:not([class="xxx"]) { padding:1px 0; } /* FOR DOTS */ .tree .ltr li.last { float:left; } .tree > ul li.last { overflow:visible; } /* OPEN OR CLOSE */ .tree li.open ul { display:block; } .tree li.closed ul { display:none !important; } /* FOR DRAGGING */ #jstree-dragged { position:absolute; top:-10px; left:-10px; margin:0; padding:0; } #jstree-dragged ul ul ul { display:none; } #jstree-marker { padding:0; margin:0; line-height:5px; font-size:1px; overflow:hidden; height:5px; position:absolute; left:-45px; top:-30px; z-index:1000; background-color:transparent; background-repeat:no-repeat; display:none; } #jstree-marker.marker { width:45px; background-position:-32px top; } #jstree-marker.marker_plus { width:5px; background-position:right top; } /* BACKGROUND DOTS */ .tree li li { overflow:hidden; } .tree > .ltr > li { display:table; } /* ICONS */ .tree ul ins { display:inline-block; text-decoration:none; width:16px; height:16px; } .tree .ltr ins { margin:0 4px 0 0px; } </style>
              
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico',contextPath:'',plugin:'wfp')}" type="image/x-icon" />
        
        
        
        <%-- we need jquery 1.4.2 for jsTree contextMenu 
        <g:javascript library="jquery" plugin="jquery" />
        --%>
        
        <g:javascript src="jquery/jquery-1.4.2.js" plugin="wfp" />
                 
        <g:javascript src="jquery/jquery-ui-1.8.custom.min.js" contextPath="" plugin="wfp" />
        <g:javascript src="jquery/jquery.timers-1.2.js"  contextPath="" plugin="wfp" />
        <g:javascript src="jquery/jquery.cluetip.js"  contextPath="" plugin="wfp" />
        
        <g:javascript src="jquery/localisation/jquery.localisation-min.js"  contextPath="" plugin="wfp" />
        <g:javascript src="jquery/scrollTo/jquery.scrollTo-min.js""  contextPath="" plugin="wfp"/>
        
        <g:javascript src="jquery/ui.multiselect.js"  contextPath="" plugin="wfp" />
        <jq:jquery>
 
            $(".step").addClass("awesome small blue button");
            $(".currentStep").addClass("awesome small red button");
            $(".nextLink").addClass("awesome small blue button");
            $(".prevLink").addClass("awesome small blue button");
            $("a.list").addClass("awesome small blue button");
            $("a.create").addClass("awesome small blue button");
            $("input.edit").addClass("awesome small blue button");
            $("input.save").addClass("awesome small blue button");
            $("input.delete").addClass("awesome small red button");
            $("a.process").addClass("awesome small blue button");
            
            /*
            $(".step").button();
            $(".currentStep").button();
            $(".nextLink").button();
            $(".prevLink").button();
            $("a.list").button();
            $("a.create").button();
            $("input.edit").button();
            $("input.save").button();
            $("input.delete").button();
            $("a.process").button();  
            $(".awesome").button();
          */
            
            
            
        	<%-- Helper for the left menu, when clicking a li the enclosed a's href  will be called --%>
          	$("div.wf4p-menu ul ul li").click(function(){
          		document.location=$(this).children("a")[0].href;
          	});
          	
         	// Initialize date picker input elements
         	$(".datepicker").datepicker({ dateFormat: "yyyy-MM-dd'T'HH:mm:ss" , changeMonth: true, changeYear:true});
          	
          	$("a.confirm").click(function(){
          	return confirm('Are you sure?')
          	});
          	
          	$.localise('ui-multiselect', {/*language: 'en',*/ path: 'js/locale/'});
			$(".multiselect").multiselect();
			//$('#switcher').themeswitcher();
			$("a.help").cluetip({splitTitle: '|'});
			
			// Sortable lists
			$(".sortable").sortable({
			 deactivate: function(event, ui) { 			  
			   var positions =ui.sender.sortable('toArray');			   			   
			   $.post("/workflow4people/"+this.id+"/sort",{'positions':positions})
			   }
			
			});
          	
          	
        </jq:jquery>
		<g:layoutHead />
	</head>
    <body>
    	<div class="masthead" style="border-bottom:1px solid #CCC;float:left;padding-bottom:5px;">
        	<div id="spinner" class="spinner" style="display:none;">
            	<img src="${createLinkTo(dir:'images',file:'spinner.gif',contextPath:'',plugin:'wfp')}" alt="Spinner" />
        	</div>	
       		<div id="logo" class="logo"><a href="${createLinkTo(dir:'',contextPath:'')}"><img src="${createLinkTo(dir:'images',file:'wf4p-150x100.png',contextPath:'')}" alt="Workflow4people" /></a></div>
        	<div class="title"><h1><g:layoutTitle default="Workflow4people" /></h1>
        	<h3 style="float:right"><g:loggedInUserInfo field="username"/></h3>
        	</div>        		   
     	</div>
     	        
	    <div class="wf4p-menu">
	      <ul>	
	      <g:ifAnyGranted role="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">      
	        <li>Workflow</li>	        	        
	        <ul>	        
	          <li><g:link controller="wf4pTask" action="list">All Tasks</g:link></li>
	          <li><g:link controller="wf4pTask" action="userlist">Tasks by user</g:link></li>
        	  <li><g:link controller="wf4pTask" action="grouplist">Group tasks</g:link></li>
	          <li><g:link controller="wf4pProcessDefinition" action="list">Process Definitions</g:link></li>
          	</ul>
          	
          	</g:ifAnyGranted>
          	<g:ifAnyGranted role="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
           <li>XML Documents</li>
           <ul>
   	          <li><g:link controller="document" action="list">XML documents</g:link></li>
   	          <g:ifAnyGranted role="ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
   	          <li><g:link controller="documentType" action="list">Types</g:link></li>
   	          <li><g:link controller="documentIndexField" action="list">Index fields</g:link></li>
   	          <li><g:link controller="minerQuery" action="list">Miner Query</g:link></li>
   	          <li><g:link controller="namespace">Namespaces</g:link></li>
   	          </g:ifAnyGranted>  	             
	        </ul>
	        </g:ifAnyGranted>
	        <g:ifAnyGranted role="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
	       <li>Search</li>
           <ul>
   	          <li><g:link controller="search" action="index">Lucene search</g:link></li>   	            	            
    	      <li><g:link controller="index" action="index">Manage index</g:link></li>
	        </ul>
	        </g:ifAnyGranted>
	        <g:ifAnyGranted role="ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER"> 	        
	        <li>Forms</li>
	        <ul>
	          <li><g:link controller="workflowDefinition">Workflow</g:link></li>
	          <li><g:link controller="dataModelEditor">Data model</g:link></li>
	          <%-- <li><g:link controller="form">Forms</g:link></li> --%>
	          
	          <li><g:link controller="fieldList">Field Lists</g:link></li>
	          <%-- <li><g:link controller="field">Fields</g:link></li> --%>
	          <li><g:link controller="fieldType">Field Types</g:link></li>
	          <li><g:link controller="baseType">Base Types</g:link></li>
	          <%-- <li><g:link controller="fieldTypeItem">Field Type items</g:link></li> --%>	          
	        </ul>
	        </g:ifAnyGranted>
	        <g:ifAnyGranted role="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
	        <li>Calendar</li>
	        <ul>
	          <li><g:link controller="dayPart" action="list" >Day parts</g:link></li>
	          <li><g:link controller="holiday" action="list" >Holidays</g:link></li>
	        </ul>
	        </g:ifAnyGranted>
	        
	        <g:ifAnyGranted role="ROLE_WF4P_USER_ADMIN,ROLE_WF4P_ADMIN">
	        <li>User Admin</li>
	        <ul>
	          <li><g:link controller="person" action="list" >Users</g:link></li>
	          <li><g:link controller="authority" action="list" >Groups</g:link></li>
	          <li><g:link controller="role" action="list" >Roles</g:link></li>
	          <li><g:link controller="action" action="list" >Actions</g:link></li>
	          <li><g:link controller="feature" action="list" >Features</g:link></li>
	          
	          <li><g:link controller="applicationConfiguration" action="list" >Configuration</g:link></li>
	          <li><g:link controller="status">Status</g:link></li>
	        </ul>
	        </g:ifAnyGranted>
	        <li>Login</li>
        	<ul>
        		<g:isNotLoggedIn>
          			<li><g:link controller="login">Login</g:link></li>
          		</g:isNotLoggedIn>
          		<g:isLoggedIn>
          			<li><g:link controller="logout">Logout</g:link></li>
          		</g:isLoggedIn>          
        	</ul>
	        
	      </ul>	      
	    </div>
    	 <g:layoutBody />
    </body>	
</html>
