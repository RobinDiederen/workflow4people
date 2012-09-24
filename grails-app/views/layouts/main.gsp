<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">--%>
<html>
    <head>
    	<!-- This is main.gsp in wfp -->
        <title><g:layoutTitle default="workflow4people" /></title>
                
        <%-- css from used modules --%>
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'ui.altselect.css',plugin:'wfp')}" />
<%--        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'awesome-buttons.css',plugin:'wfp')}" />--%>
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'jquery.cluetip.css',plugin:'wfp')}" />
    	<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'datatables.css',plugin:'wfp')}" />
	
        <%-- Workflow4people style --%>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'workflow4people.css',plugin:'wfp')}" />	
	
		<%-- Theme style --%>
		<link rel="stylesheet" type="text/css" href="${resource(dir:'css/theme',file:'roller-theme.css',plugin:'wfp')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css/theme',file:'theme.css',plugin:'wfp')}" />
                      
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico',plugin:'wfp')}" type="image/x-icon" />
        
        
        
        <%-- we need jquery 1.4.2 for jsTree contextMenu 
        <g:javascript library="jquery" plugin="jquery" />
        --%>
        
        <g:javascript src="jquery/jquery-1.4.2.js" plugin="wfp" />
        <g:javascript>
        	var wfp={};
        	var dataTableHashList = {};
        	wfp.baseUrl="${request.contextPath}";
        </g:javascript>
                 
        <g:javascript src="jquery/jquery-ui-1.8.custom.min.js" contextPath="" plugin="wfp" />
        <g:javascript src="jquery/jquery.timers-1.2.js"  contextPath="" plugin="wfp" />
        <g:javascript src="jquery/jquery.cluetip-patched.js"  contextPath="" plugin="wfp" />
        <g:javascript src="jquery/jquery.dataTables.js"  contextPath="" plugin='wfp'/>
        
        <g:javascript src="jquery/localisation/jquery.localisation-min.js"  contextPath="" plugin="wfp" />
        <g:javascript src="jquery/scrollTo/jquery.scrollTo-min.js""  contextPath="" plugin="wfp"/>
        
        <g:javascript src="jquery/jquery.ui.altselect.js"  contextPath="" plugin="wfp" /> 
        <g:javascript src="workflow4people.js"  contextPath="" plugin="wfp" />
        
        <jq:jquery>
			<%-- NEW Look buttons--%>
			$(".awesome").removeClass("small awesome blue button").button();
            
            $(".step").removeClass("small awesome blue button").button();
            $(".currentStep").removeClass("small awesome red button").button();
            $(".nextLink").removeClass("small awesome blue button").button();
            $(".prevLink").removeClass("small awesome blue button").button();
            
            $("a.list").removeClass("small awesome blue button").button();
            $("a.create").removeClass("small awesome blue button").button();
            $("input.edit").removeClass("small awesome blue button").button();
            $("input.save").removeClass("small awesome blue button").button();
            $("input.delete").removeClass("small awesome red button").button();
            $("a.process").removeClass("small awesome blue button").button();     
                   
        	<%-- Helper for the left menu, when clicking a li the enclosed a's href  will be called --%>
			$("div.wf4p-menu ul ul li a").each(function (index) {
				var curMatch = $(this);
				curMatch.parent().click(function(){
					document.location = curMatch[0].href;
				});
			});
			
			<%-- Hide jBpm menu if not used	--%>
			var pathName = window.location.pathname;
			if (pathName.split('/')[2].substring(0, 4) == "wf4p") {
				$("#jbpmMenuItems").toggleClass("hideElement");
			}
			$("#jbpmMenu").click(function(){
				$("#jbpmMenuItems").toggleClass("hideElement");
			});
			          	
         	// Initialize date picker input elements
         	$(".datepicker").datepicker({ dateFormat: "yyyy-MM-dd'T'HH:mm:ss" , changeMonth: true, changeYear:true});
          	
          	$("a.confirm").live("click",function(){
          	return confirm('Are you sure?')
          	});
          	
			$(".help").cluetip({splitTitle: '|'});
			
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
    
     <div id="main-toolbar" >
    	<span id="menu-toolbar">
    		<a href="/workflow4people/" title="Home|Go to the home screen" class="action home help" >&nbsp;</a>
    	</span>
    	
    	<span id="user-toolbar" style="float:right;">    		    		
    		<sec:ifLoggedIn><sec:loggedInUserInfo field="username"/><g:link title="logout" class="logout action" controller="logout">&nbsp;</g:link></sec:ifLoggedIn>
    	</span>
    
    	</div>
    
     	        		   
     	   <div class="page-body" >
     	          
	    <div class="wf4p-menu">
	    <div id="topleft-logo" class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr table-title">
	    <h1>workflow<span class="red">4</span>people</h1></div>
	      <ul>	
	      <sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">      
	        <li>Workflow</li>	        	        
	        <ul>	        
	          <li class="menu-icon menu-workflowdefinition"><g:link controller="workflowDefinition" action="list">Workflow Def</g:link></li>
	          <li class="menu-icon workflows"><g:link controller="workflow" action="list">Workflows</g:link></li>
        	  <li class="menu-icon tasks" ><g:link controller="task" action="list">Tasks</g:link></li>
        	  <li class="menu-icon tasks" ><g:link controller="taskStatus" action="list">Task statuses</g:link></li>
          	</ul>
          	<li>Engines</li>
          	<ul>
          	<li id="jbpmMenu" class="menu-icon jbpm">jBPM</li>	        	        
	        <ul id="jbpmMenuItems" class="hideElement">	        
	          <li class="menu-icon menu-alltasks"><g:link controller="wf4pTask" action="list">All Tasks</g:link></li>
	          <li class="menu-icon mytasks"><g:link controller="wf4pTask" action="userlist">Tasks by user</g:link></li>
        	  <li class="menu-icon grouptasks" ><g:link controller="wf4pTask" action="grouplist">Group tasks</g:link></li>
	          <li class="menu-icon processdefinitions" ><g:link controller="wf4pProcessDefinition" action="list">Process Def's</g:link></li>
          	</ul>
          	</ul>
          	
          	</sec:ifAnyGranted>
          	<sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
           <li>XML Documents</li>
           <ul>
   	          <li class="menu-icon xmldocuments" ><g:link controller="document" action="list">XML documents</g:link></li>
   	          <sec:ifAnyGranted roles="ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
   	          <li  class="menu-icon menu-types"><g:link controller="documentType" action="list">Types</g:link></li>
   	          <li class="menu-icon menu-index-fields"><g:link controller="documentIndexField" action="list">Index fields</g:link></li>
   	          <li class="menu-icon miner"><g:link controller="minerQuery" action="list">Miner Query</g:link></li>
   	          <li  class="menu-icon menu-namespaces"><g:link controller="namespace">Namespaces</g:link></li>
   	          </sec:ifAnyGranted>  	             
	        </ul>
	        </sec:ifAnyGranted>
	        <sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
	       <li>Search</li>
           <ul>
   	          <li class="menu-icon menu-search"><g:link controller="search" action="index">Lucene search</g:link></li>   	            	            
    	      <li class="menu-icon menu-manage-index"><g:link controller="index" action="index">Manage index</g:link></li>
	        </ul>
	        </sec:ifAnyGranted>
	        <sec:ifAnyGranted roles="ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER"> 	        
	        <li>Forms</li>
	        <ul>
<%--	          <li class="menu-icon menu-workflowdefinition"><g:link controller="workflowDefinition">Workflow Def</g:link></li>--%>
	          <li class="menu-icon menu-datamodel"><g:link controller="dataModelEditor">Data model</g:link></li>
	          
	          
	          <li  class="menu-icon menu-fieldlist"><g:link controller="fieldList">Field Lists</g:link></li>
	          
	          <li  class="menu-icon menu-fieldtype"><g:link controller="fieldType">Field Types</g:link></li>
	          <li  class="menu-icon menu-basetype"><g:link controller="baseType">Base Types</g:link></li>
	          	          
	        </ul>
	        </sec:ifAnyGranted>
	        <sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
	        <li>Calendar</li>
	        <ul>
	          <li class="menu-icon dayparts"><g:link controller="dayPart" action="list" >Day parts</g:link></li>
	          <li class="menu-icon holidays"><g:link controller="holiday" action="list" >Holidays</g:link></li>
	        </ul>
	        </sec:ifAnyGranted>
	        
	        <sec:ifAnyGranted roles="ROLE_WF4P_USER_ADMIN,ROLE_WF4P_ADMIN">
	        <li>User Admin</li>
	        <ul>
	          <li class="menu-icon menu-users"><g:link controller="person" action="list" >Users</g:link></li>
	          <li class="menu-icon menu-groups"><g:link controller="authority" action="list" >Groups</g:link></li>
	          <li class="menu-icon menu-roles"><g:link controller="role" action="list" >Roles</g:link></li>
	          <li class="menu-icon menu-action"><g:link controller="action" action="list" >Actions</g:link></li>
	          <li class="menu-icon menu-feature"><g:link controller="feature" action="list" >Features</g:link></li>
	          <li class="menu-icon menu-feature"><g:link controller="workflowEngine" action="list" >Engines</g:link></li>
	          <li class="menu-icon configuration"><g:link controller="applicationConfiguration" action="list" >Configuration</g:link></li>
	          <li class="menu-icon status"><g:link controller="status" action="status">Status</g:link></li>
	        </ul>
	        </sec:ifAnyGranted>
	        <li>Login</li>
        	<ul>
        		<sec:ifNotLoggedIn>
          			<li class="menu-icon menu-login"><g:link controller="login">Login</g:link></li>
          		</sec:ifNotLoggedIn>
          		<sec:ifLoggedIn>
          			<li class="menu-icon menu-logout"><g:link controller="logout">Logout</g:link></li>
          		</sec:ifLoggedIn>          
        	</ul>
	        
	      </ul>	      
	    </div>

    	 <g:layoutBody />
    	 	    </div>
    </body>	
</html>
