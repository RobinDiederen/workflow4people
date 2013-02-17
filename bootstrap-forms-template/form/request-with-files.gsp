<html xmlns:w="w" xmlns:f="f" xmlns:g="g" xmlns:form="form" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${form.title}</title>        
        <ccmis:head path="*{document.header.cmis.path.text()}" username="*{session.username}" />
                 
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="request" process="${form.workflow.name}" type="request">			
			<w:pages form="${form}" var="page">
				<w:sections page="${page}" var="section">
					<legend>${section.title}
						<small>${section.message}</small>
					</legend>			
			 		<w:items section="${section}" var="formItem" >
			 			<!-- START w:snippet var="${formItem}" name="${formItem.snippet}" * ${formItem.class.name} - ${formItem.field.name} -->
						<w:snippet var="${formItem}" name="${formItem.snippet}" />
						<!-- END w:snippet var="${formItem}" name="${formItem.snippet}" * -->
					</w:items>
				</w:sections>
			</w:pages>
			<legend>Bestanden
						<small>Voeg hier bestanden toe aan uw aanvraag</small>
					</legend>
			<div class="control-group">
	  			<label class="control-label" for="upload">Bestanden</label>
				<div class="controls">
					<ddialog:upload action="*{createLink(controller:'cmisDocument',action: 'fileupload')}" class="btn"/>		
				</div>
			</div>		
					
			
			
			<div class="control-group">
	  			<label class="control-label" for="comment">*{g.message(code: 'comment')}</label>
				<div class="controls">
					<w:snippet type="Form" name="comment" />
				</div>
			</div>
		</form:form>
	</body>
</html>
