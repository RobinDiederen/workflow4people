<!-- label ${field.name} -->
<div class="control-group" >
	<label class="control-label ${field.dependencySource ? 'dependency-source ' : ''}${field.dependsOn ? 'dependency-target ' : ''}" for="${field.name}">${attrs.label}</label>
	<div class="controls ${field.dependencySource ? 'dependency-source ' : ''}${field.dependsOn ? 'dependency-target ' : ''}">
	<span class="uneditable-input input-xxlarge">	
   		${body}
   		</span>
  	</div>
</div>