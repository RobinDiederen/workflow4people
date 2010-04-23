<html>
    <head>
        <title><g:layoutTitle default="workflow4people" /></title>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'workflow4people.css')}" />
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />				
    </head>
    <body>
        	<div class="masthead" style="border-bottom:1px solid #CCC;float:left;padding-bottom:5px;">
    
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>	
        
        <div id="logo" class="logo"><a href="${createLinkTo(dir:'')}"><img src="${createLinkTo(dir:'images',file:'wf4p-150x100.png')}" alt="Workflow4people" /></a></div>
        
        <div class="title" style="float:left;width:800px;"><h1><g:layoutTitle default="workflow4people" /></h1></div>
        </div>	
        <g:layoutBody />		
    </body>	
</html>
