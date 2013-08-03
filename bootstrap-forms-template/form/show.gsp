<form:form  style="width:1200px;height:auto;" action="/forms/form/submit" title="${form.title}" explanation="${form.explanationMessage}" name="show" process="${form.workflow.name}" type="show" >			
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

