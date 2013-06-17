<!-- form.gsp -->
<w:tag name="form:input" attributes="${parameters}" type="text" 
			class="${field.nillable ? '' : 'required'} fieldtype-${fieldTypeName} field-${name} ${field.dependencySource ? 'dependency-source' : ''} input-large parameters.cssClass" 
			regexp="${parameters.pattern}"
			depends-on="update-document.${field.dependsOn?.gpath}"
			dependency-type="${field.dependencyType}"
			dependency-parameter="${field.dependencyParameter}"

			gpath="document.${gpathExpr}" value="*{document.${gpath}}" helpTitle="${label}" helpBody="${help}" title ="${alert}" 
			/>
