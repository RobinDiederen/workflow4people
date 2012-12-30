<html xmlns:w="w" xmlns:f="f" xmlns:g="g"  xmlns:form="form" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${form.title}</title>       
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="request" process="${form.workflow.name}" type="request">			
			<w:pages form="${form}" var="page">
				<w:sections page="${page}" var="section">						
			 		<w:items section="${section}" var="formItem" >
						<w:snippet var="${formItem}" name="${formItem.snippet}" />
					</w:items>
				</w:sections>
			</w:pages>
		<%--
			<w:formItems form="${form}" var="formItem" >
				<label class="control-label" for="${formItem.field.name}">${formItem.field.binding.label}</label>
				<div class="controls">
					<w:snippet var="${formItem}" name="${formItem.snippet}" />
				</div>      		
    		</w:formItems>
    		--%>
    		 <div class="control-group">
	  			<label class="control-label" for="comment">*{g.message(code: 'comment')}</label>
	   			<div class="controls">
	   				<w:snippet type="Form" name="comment" />
	   			</div>
			</div>    		
		</form:form>
	</body>
</html>