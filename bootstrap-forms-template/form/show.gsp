<html xmlns:w="w" xmlns:f="f" xmlns:g="g" xmlns:form="form" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${form.title}</title>
        <%--<ccmis:head path="*{document.header.cmis.path.text()}" username="*{session.username}" readOnly="true"></ccmis:head>--%>
    </head>
	<body>
		<form:form action="submit" title="${form.title}" explanation="${form.explanationMessage}" name="show" process="${form.workflow.name}" type="show">			
			<w:pages form="${form}" var="page">
				<w:sections page="${page}" var="section">
					<legend>${section.title}
						<small>${section.message}</small>
					</legend>			
			 		<w:items section="${section}" var="formItem" >
						<w:snippet var="${formItem}" name="${formItem.snippet}" model="${[readonly:true]}"/>         
					</w:items>
				</w:sections>
			</w:pages>
			<div class="control-group">
	  			<label class="control-label" for="comment">*{g.message(code: 'comment')}</label>
				<div class="controls">					
					<form:comment document="*{document}" mode="show" value="*{comment}"/>			
				</div>
			</div>    		
		</form:form>
		<%--<ccmis:list />--%>
	</body>
</html>
