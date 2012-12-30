<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" [
 <!ENTITY euro "&#x20AC;">
 <!ENTITY nbsp "&#160;"> 
 ]>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${form.title}</title>       
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="${form.name}" process="${form.workflow.name}" type="task" task="*{task}">
			<table>
			<w:pages form="${form}" var="page">
			<w:sections page="${page}" var="section">						
			 <w:items section="${section}" var="formItem" >
        		<tr>
        		  <td colspan="2">&nbsp;</td>
        		</tr>
        		<g:if test="${formItem.field.binding.label.length() > 0}">
          		<tr class="section-head">
          		  <td colspan="2">${formItem.field.binding.label}</td>
          		</tr>
        		</g:if>			 	        		        	
        		<w:snippet var="${formItem}" name="${formItem.snippet}" />         	
        	</w:items>
        	</w:sections>
        	</w:pages>
      		<tr>
      		  <td colspan="2">&nbsp;</td>
      		</tr>
      		<tr class="section-head">
      		  <td colspan="2">*{g.message(code: 'comment')}</td>
      		</tr>
        	<w:snippet type="Form" name="comment" />
			</table>
			<div><br/><br/></div>
		</form:form>
	</body>
</html>	
			
