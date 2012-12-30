<!-- form.gsp -->
<form:input type="text" 
			class="${field.nillable ? '' : 'required'} fieldtype-${fieldTypeName} field-${name} ${field.dependencySource ? 'dependency-source' : ''}" 
			regexp="${pattern}" 
			minlength="${minLength}"
			maxlength="${maxLength}"
			 
			min="${minInclusive}" 
			max="${maxInclusive}"
			
			minexcl="${minExclusive}" 
			maxexcl="${maxExclusive}"
			
			depends-on="update-document.${field.dependsOn?.gpath}"
			dependency-type="${field.dependencyType}"
			dependency-parameter="${field.dependencyParameter}"
			
			gpath="document.${gpathExpr}"  value="*{document.${gpath}}" helpTitle="${label}" helpBody="${help}" title ="${alert}" 
			
			/>
