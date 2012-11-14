<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" [
 <!ENTITY euro "&#x20AC;">
 <!ENTITY nbsp "&#160;"> 
 ]>
<html xmlns:w="w" xmlns:f="f" xmlns:g="g" xmlns:form="form" xmlns:xforms="xforms" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${form.title}</title>
        <link rel="stylesheet" media="print" type="text/css" href="file:/home/joost/workspaces/grails-workspace/wfp-forms/web-app/css/print.css" />       
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="request" process="${form.workflow.name}" type="show">
			<div style="float:right;clear:both;">
				<f:link title="Show PDF of this form" controller="form" action="pdf" id="*{document.header.documentId}"><img src="*{resource(dir:'images',file:'application-pdf.png')}" /></f:link>
			</div>	
			<table>						
			 <w:formItems form="${form}" var="formItem" >			 	        		        	
        		<w:snippet var="${formItem}" name="${formItem.snippet}" model="${[readonly:true]}"/>         	
        	</w:formItems>
        	<w:snippet type="Form" name="readonlyComment" />
			</table>
		</form:form>
	</body>
</html>	
			