<html>
    <head>
        <title><g:layoutTitle default="workflow4people" /></title>
        <%-- Standard Grails scaffolding style--%>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
        <%-- Workflow4people style--%>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'workflow4people.css')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css/redmond',file:'jquery-ui-1.7.2.custom.css')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'ui.multiselect.css')}" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'awesome-buttons.css')}" />
        
                
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
                
        <g:javascript library="jquery"/>
        <%-- <g:javascript src="jquery/jquery-ui-1.7.2.custom.min.js" /> --%>
        <g:javascript src="jquery/jquery-ui-1.8.custom.min.js" />
        <g:javascript src="jquery/localisation/jquery.localisation-min.js" />
        <g:javascript src="jquery/scrollTo/jquery.scrollTo-min.js"" />
        
        <g:javascript src="jquery/ui.multiselect.js" />
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
          	
          	
        </jq:jquery>
		<g:layoutHead />
	</head>
    <body>
    	<div class="masthead" style="border-bottom:1px solid #CCC;float:left;padding-bottom:5px;">
        	<div id="spinner" class="spinner" style="display:none;">
            	<img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        	</div>	
       		<div id="logo" class="logo"><a href="${createLinkTo(dir:'')}"><img src="${createLinkTo(dir:'images',file:'wf4p-150x100.png')}" alt="Workflow4people" /></a></div>
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
