<!-- form.gsp -->
<form:input type="text" 
			class="${field.nillable ? '' : 'required'} fieldtype-${fieldTypeName} field-${name} ${field.dependencySource ? 'dependency-source' : ''} input-large parameters.cssClass" 
			regexp="${parameters.pattern}" 
			minlength="${parameters.minLength}"
			maxlength="${parameters.maxLength}"
			 
			min="${parameters.minInclusive}" 
			max="${parameters.maxInclusive}"
			
			minexcl="${parameters.minExclusive}" 
			maxexcl="${parameters.maxExclusive}"
			
			depends-on="update-document.${field.dependsOn?.gpath}"
			dependency-type="${field.dependencyType}"
			dependency-parameter="${field.dependencyParameter}"
			
			gpath="document.${gpathExpr}"  value="*{document.${gpath}}" helpTitle="${label}" helpBody="${help}" title ="${alert}" 
			
			/>
