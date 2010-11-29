<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Data model editor</title>
                
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.treeview.css',contextPath:pluginContextPath)}" />
        <link rel="stylesheet" href="${createLinkTo(dir:'css/dme',file:'jquery.jstree.css',contextPath:pluginContextPath)}" />
        
        
        <link rel="stylesheet" href="${createLinkTo(dir:'css/dme',file:'editor.css',contextPath:pluginContextPath)}" />
        
		
		<g:javascript src="jquery/jquery.cookie.js" contextPath="${pluginContextPath}" />
		<g:javascript src="jquery/jquery.hotkeys.js" contextPath="${pluginContextPath}" />
		
		<g:javascript src="jquery/jquery.jstree.js" contextPath="${pluginContextPath}" />
	
		<g:javascript src="jquery/jquery.cluetip.js" contextPath="${pluginContextPath}" />
		<g:javascript src="dme/editor.js" contextPath="${pluginContextPath}" />		
    </head>
    <body>
	    <div class="body">
	    	<div class="flash">
	    	    <g:if test="${flash.message}">
	            <div class="message" style="height:20px;">${flash.message}</div>
	            <div class="message" style="height:20px;">&nbsp;</div>
	            </g:if>
	    	</div>
	    	<div id="status" style="display:none;position:absolute;left:50px;top:50px;width:100px;border:1px solid #AAA;background-color:#EEE;text-align:center;padding:10px;" ></div>
	    	<g:formRemote name="editor" update="editpane" url="[action:'submit']">
	    		<%-- Navigation/edit buttons --%>
		        <div class="nav" style="padding-left:5px;width:805px;clear:both;">            
		            <span><a id="editButton" href="" class="awesome small blue button" >edit</a></span>
		            <span><a id="createFieldButton" href="" class="awesome small blue button" >create field</a></span>
		            <span><a id="createFieldListButton" href="" class="awesome small blue button" >create field list</a></span>
		        </div>
		        <%-- Data model tree --%>
		        <div id="outer-treediv" style="float:left;width:300px;height:500px;border:1px solid #DDD;">   
		            <div id="treediv" class="dialog" style="float:left;width:95%;height:95%;overflow:auto;">           
		            	<ul id="tree" class="filetree treeview">            	
		            	<g:each in="${org.workflow4people.FieldList.findAll([sort:'name'])}" var="fieldListInstance" >            	
			            	<li id="fieldlist_${fieldListInstance.id}" rel="rootFieldList" class="field"><a class="fieldlist" id="${fieldListInstance.id}" href="#"><ins>&nbsp;</ins>${fieldListInstance.name}</a>
			            	<ul>
			            	<wform:modelTree fieldList="${fieldListInstance}" ></wform:modelTree>
			            	</ul>
			            	</li>
		            	</g:each>            	
		            	</ul> 
		            </div>
				</div>
				<%-- Show/edit pane --%>
				<div id="outer-editpane" style="float:left;width:500px;height:500px;border:1px solid #DDD;margin-left:5px;">
		            <div id="editpane" style="float:left;width:95%;height:95%;overflow:auto;">            
		            	Select a field on the left to show the field details in this pane.
		            </div>
				</div>
			</g:formRemote>
		</div>
        
    </body>
</html>
