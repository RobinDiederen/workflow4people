<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" [
 <!ENTITY euro "&#x20AC;">
 <!ENTITY nbsp "&#160;"> 
 ]>
<html xmlns:w="w" xmlns:f="f" xmlns:g="g" xmlns:form="form" xmlns:xforms="xforms" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Printversie ${form.title}</title>
        <link rel="stylesheet" media="print" type="text/css" href="file://*{formsPath}common/css/print.css" />
        
               
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="request" process="${form.workflow.name}" type="show">			
			<table>						
			 <w:formItems form="${form}" var="formItem" >			 	        		        	
        		<tr>
        		  <td colspan="2">&nbsp;</td>
        		</tr>
        		<g:if test="${formItem.field.binding.label.length() > 0}">
          		<tr class="section-head">
          		  <td colspan="2"><b>${formItem.field.binding.label}</b></td>
          		</tr>
        		</g:if>	
        		<w:snippet var="${formItem}" name="${formItem.snippet}" model="${[readonly:true]}"/>         	
        	</w:formItems>
      		<tr>
      		  <td colspan="2">&nbsp;</td>
      		</tr>
      		<tr class="section-head">
      		  <td colspan="2">*{g.message(code: 'comment')}</td>
      		</tr>
        	<w:snippet type="Form" name="readonlyComment" />
			</table>
		</form:form>
	</body>
</html>	
			
