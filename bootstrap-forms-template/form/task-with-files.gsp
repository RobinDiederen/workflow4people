<form:form style="width:1200px;height:auto;" action="/forms/form/submit" title="${form.title}" explanation="${form.explanationMessage}" name="request" process="${form.workflow.name}" type="task" task="*{task}">			
        <w:pages form="${form}" var="page">
                <w:sections page="${page}" var="section">
                        <legend>${section.title}
                                <small>${section.message}</small>
                        </legend>			
                        <w:items section="${section}" var="formItem" >
                                <w:snippet var="${formItem}" name="${formItem.snippet}" />         
                        </w:items>
                </w:sections>
        </w:pages>
        <div class="control-group">
                <label class="control-label" for="comment">*{g.message(code: 'comment')}</label>
                <div class="controls">
                        <w:snippet type="Form" name="comment"/>
                </div>
        </div>    		
</form:form>
<f:if test="*{document.header?.cmis?.path?.text().size()!=0}" >
        <ccmis:list />
</f:if>

			
