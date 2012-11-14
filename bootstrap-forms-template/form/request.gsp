<html xmlns:w="w" xmlns:f="f" xmlns:g="g"  xmlns:form="form"  xmlns:xforms="xforms">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${form.title}</title>       
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="request" process="${form.workflow.name}" type="request">
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
			</table>
			<div><br/><br/></div>
		</form:form>
	</body>
</html>	
			
