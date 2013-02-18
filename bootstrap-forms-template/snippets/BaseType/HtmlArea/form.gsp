<form:input  
			depends-on="update-document.${field.dependsOn?.gpath}"
			dependency-type="${field.dependencyType}"
			dependency-parameter="${field.dependencyParameter}"

			type="textarea" rows="4" cols="40" theme="advanced" plugins="fullscreen" theme="simple" plugins="fullscreen" class="ckeditor fieldtype-${fieldTypeName} field-${field.name} ${field.dependsOn ? 'dependency-target' : ''}" minlength="2" gpath="document.${gpathExpr}"  value="*{document.${gpath}}" helpTitle="${label}" helpBody="${help}" title="${alert}" />
