<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" [
 <!ENTITY euro "&#x20AC;">
 <!ENTITY nbsp "&#160;"> 
 ]>
<html xmlns:w="w" xmlns:f="f" xmlns:g="g" xmlns:form="form"  xmlns:xforms="xforms">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${form.title}</title>       
        <ccmis:head path="*{document.header.cmis.path.text()}" username="*{session.username}"></ccmis:head>        
                
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="${form.name}" process="${form.workflow.name}" type="task" task="*{task}">
			<table>						
			 <w:formItems form="${form}" var="formItem" >
        		<tr>
        		  <td colspan="2">&nbsp;<td>
        		</tr>
        		<g:if test="${formItem.field.binding.label.length() > 0}">
          		<tr class="section-head">
          		  <td colspan="2">${formItem.field.binding.label}</td>
          		</tr>
        		</g:if>			 	        		        	
        		<w:snippet var="${formItem}" name="${formItem.snippet}" />         	
        	</w:formItems>
      		<tr>
      		  <td colspan="2">&nbsp;<td>
      		</tr>
      		<tr class="section-head">
      		  <td colspan="2">*{g.message(code: 'comment')}</td>
      		</tr>
        	<w:snippet type="Form" name="comment" />
        	       		<tr class="section-head">
    			<td colspan="2">*{g.message(code: 'forms.section.documents.title')}</td>
    		</tr>
		    <tr>
				<td style="vertical-align:top" colspan="2"><ccmis:list/></td>	
			</tr>       
			</table>
			<div id="status" style="display:none;position:absolute;left:50px;top:50px;width:100px;border:1px solid #AAA;background-color:#EEE;text-align:center;padding:10px;" ></div>		
		</form:form>
	</body>
</html>	
			
