<form:form style="width:1200px;height:auto;" action="/forms/form/submit/${form.name}" title="${form.title}" explanation="${form.explanationMessage}" name="task" process="${form.workflow.name}" type="task" outcomes="*{outcomes}">
  <w:pages form="${form}" var="page">
    <ul class="nav nav-tabs">
      <w:sections page="${page}" var="section">       
        <li class="${section.position==1?'active':''}"><a id="tabhead-${section.position}" class="tab" href="#tab-${section.position}" xdata-toggle="tab" >${section.title}</a></li>            
      </w:sections>
      <li><a class="tab" href="#tab-comment" xdata-toggle="tab" >Commentaar</a></li> 
    </ul>
    <div class="tab-content">
      <w:sections page="${page}" var="section">       
        <div class="tab-pane ${section.position==1?'active':''}" id="tab-${section.position}">
          <div class="section-message">${section.message}</div>
          <w:items section="${section}" var="formItem" >
            <!-- START w:snippet var="${formItem}" name="${formItem.snippet}" * ${formItem.class.name} - ${formItem.field.name} -->
            <w:snippet var="${formItem}" name="${formItem.snippet}" />
            <!-- END w:snippet var="${formItem}" name="${formItem.snippet}" * -->
          </w:items>
        </div>
      </w:sections>
    <div class="tab-pane " id="tab-comment">
      <div class="control-group">
        <label class="control-label" for="comment">*{g.message(code: 'comment')}</label>
        <div class="controls">
          <w:snippet type="Form" name="comment" />
        </div>
      </div>
    </div>
    </div>
  </w:pages>
</form:form>