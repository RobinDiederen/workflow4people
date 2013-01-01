<!-- label ${field.name} -->
<div class="control-group" >
	<label class="control-label ${field.dependencySource ? 'dependency-source ' : ''}${field.dependsOn ? 'dependency-target ' : ''}" for="${field.name}">${label}</label>
	<div class="controls ${field.dependencySource ? 'dependency-source ' : ''}${field.dependsOn ? 'dependency-target ' : ''}">	
   		<w:snippet var="${field}" name="readonlyForm" />
  	</div>
</div>