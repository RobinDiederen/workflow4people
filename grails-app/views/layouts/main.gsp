<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
    	<!-- This is main.gsp in wfp -->
        <title><g:layoutTitle default="workflow4people" /></title>
		<r:require modules="wfp"/>
        <g:javascript>
        	var wfp={};
        	var dataTableHashList = {};
        	wfp.baseUrl="${request.contextPath}";
        </g:javascript>        
        <g:layoutHead />
		<r:layoutResources/>		
		<dialog:head />       
	</head>
    <body>
            
    	<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-inner">
        		<div class="container">        		      
          			<div class="nav-collapse collapse">
	            		<ul class="nav">            
		              		<li class="">                
		                		<a href="/workflow4people" class="brand" >Workflow4people</a>
		              		</li>
		    		   		        
			   		        <sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
		              			<dialog:dropdown code="wfp.workflow">
									<dialog:menuitem controller="workflowDefinition" action="list" icon="icon-list"/>
									<dialog:menuitem controller="workflow" action="list" icon="icon-list"/>
			              			<dialog:menuitem controller="task" action="list" icon="icon-tasks"/>
			              			<dialog:menuitem controller="taskStatus" action="list" icon="icon-list"/>
								</dialog:dropdown>														
		              			<dialog:dropdown code="wfp.engines">
		              				<dialog:submenu code="wfp.jbpm4">
		              					<dialog:menuitem controller="wf4pTask" action="list" icon="icon-list"/>
		              					<dialog:menuitem controller="wf4pTask" action="userlist" icon="icon-list"/>
		              					<dialog:menuitem controller="wf4pTask" action="grouplist" icon="icon-list"/>
		              					<dialog:menuitem controller="wf4pProcessDefinition" action="list" icon="icon-list"/>		              					
		              				</dialog:submenu>
		              				<dialog:submenu code="wfp.activiti">
		              					<dialog:menuitem controller="workflowDefinition" action="list" icon="icon-list"/>
		              				</dialog:submenu>		              				
	              				</dialog:dropdown>
	              			</sec:ifAnyGranted>	
	            			<sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
	            				<dialog:dropdown code="wfp.xmldocuments">
	            					<dialog:menuitem controller="document" action="list" icon="icon-file"/>
	            					<dialog:menuitem controller="documentType" action="list" icon="icon-file"/>
	            					<dialog:menuitem controller="documentIndexField" action="list" icon="icon-list"/>
	            					<dialog:menuitem controller="minerQuery" action="list" icon="icon-cog"/>
	            					<dialog:menuitem controller="namespace" action="list" icon="icon-folder-close"/>
            					</dialog:dropdown>
            				</sec:ifAnyGranted>
							<sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
            				 	<dialog:dropdown code="wfp.search">
            				 		<dialog:menuitem controller="search" action="searchdocument" icon="icon-file"/>
            				 		<dialog:menuitem controller="search" action="searchtask" icon="icon-tasks"/>
            				 		<dialog:menuitem controller="index" action="index" icon="icon-list"/>
            				 		<dialog:menuitem controller="solr" action="overview" icon="icon-asterisk"/>
            				 		<dialog:menuitem controller="solr" action="status" icon="icon-asterisk"/>
            				 		<dialog:menuitem controller="solr" action="reIndex" icon="icon-asterisk" onclick="dialog.formDialog(null,'solr',{dialogname:'reIndex',submitname:'submitReIndex',submitform:true},null)" />
           				 		</dialog:dropdown>
					        </sec:ifAnyGranted>
		        	        <sec:ifAnyGranted roles="ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
			        	        <dialog:dropdown code="wfp.forms">
			        	        	<dialog:menuitem controller="form" action="list" icon="icon-list"/>
        	        	 	        <dialog:menuitem controller="dataModelEditor" action="index" icon="icon-list"/>
        	        	 	        <dialog:menuitem controller="field" action="list" icon="icon-list"/>
        	        	 	        <dialog:menuitem controller="fieldType" action="list" icon="icon-list"/>
        	        	 	        <dialog:menuitem controller="baseType" action="list" icon="icon-list"/>
       	        	 	        </dialog:dropdown>
							</sec:ifAnyGranted>
							<sec:ifAnyGranted roles="ROLE_WF4P_PROCESS_ADMIN,ROLE_WF4P_ADMIN,ROLE_WF4P_DEVELOPER">
								<dialog:dropdown code="wfp.calendar">
									<dialog:menuitem controller="dayPart" action="list" icon="icon-calendar"/>
									<dialog:menuitem controller="holiday" action="list" icon="icon-calendar"/>
								</dialog:dropdown>
						  	</sec:ifAnyGranted>
						  	
			  		        <sec:ifAnyGranted roles="ROLE_WF4P_USER_ADMIN,ROLE_WF4P_ADMIN">
								<dialog:dropdown code="wfp.admin">
									<dialog:menuitem controller="person" action="list" icon="icon-user"/>
									<dialog:menuitem controller="authority" action="list" icon="icon-user"/>
									<dialog:menuitem controller="role" action="list" icon="icon-user"/>
									<dialog:menuitem controller="action" action="list" icon="icon-list"/>
									<dialog:menuitem controller="feature" action="list" icon="icon-star"/>
									<dialog:menuitem controller="workflowEngine" action="list" icon="icon-cog"/>
									<dialog:menuitem controller="applicationConfiguration" action="list" icon="icon-wrench"/>
									<dialog:menuitem controller="status" action="status" icon="icon-info-sign"/>
								</dialog:dropdown>							
	        				</sec:ifAnyGranted>
							
	                	
			    		<ul class="nav pull-right">
		       				<li><sec:ifLoggedIn>
		       					<g:link title="logout" controller="logout"><sec:loggedInUserInfo field="username"/></g:link>		       					
		       				</sec:ifLoggedIn>
		       				</li>
		       			</ul>
		       					       				      			            
					</div>
					          
				</div>
			</div>
		</div>

	    <div class="container" id="page">               
        	<div class="row">
        		<div class="span12" style="margin-top:45px;">        			
	        		<div id="statusmessage">	        		
	        		<g:if test="${flash.message}">        		
	        	    	<div class="alert alert-success">
	    					<button type="button" class="close" data-dismiss="alert">×</button>
	    					${flash.message}
	    				</div>
	   				</g:if>	        		
	   				</div>
	        		<g:if test="${flash.errorMessage}">        		
	        	    	<div class="alert alert-error">
	    					<button type="button" class="close" data-dismiss="alert">×</button>
	    					${flash.errorMessage}
	    				</div>
	   				</g:if>
   				</div>
 			</div>   				
   			<g:layoutBody />
   			<r:layoutResources />
		</div>
    </body>	
</html>
