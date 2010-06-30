					
					
					<div id="tabs" style="border:none;"> 
					<ul>						
							<li>
								<a href="#details">Details</a>
							</li>
						
						<li>
							<a href="#advanced">Advanced</a>
						</li>
						
					</ul>
					
					<div id="details">
						<g:hiddenField name="detailType" value="edit"/>
						<g:hiddenField name="detailClass" value="Field"/>					
						<g:hiddenField name="detailId" value="${fieldInstance.id}"/>
                    <table style="border:none;">
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.fieldPosition" default="Field Position" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "fieldPosition")}</td>
                                
                            </tr>
                            
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="field.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldInstance?.name}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="fieldType"><g:message code="field.fieldType.label" default="Field Type" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'fieldType', 'errors')}">
                                    <g:select name="fieldType.id" from="${org.workflow4people.FieldType.list()}" optionKey="id" value="${fieldInstance?.fieldType?.id}"  />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.fieldType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="childFieldList"><g:message code="field.childFieldList.label" default="Child Field List" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'childFieldList', 'errors')}">
                                    <g:select name="childFieldList.id" from="${org.workflow4people.FieldList.list()}" optionKey="id" value="${fieldInstance?.childFieldList?.id}" noSelection="['null': '']" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.childFieldList.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="field.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${fieldInstance?.description}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.description.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="defaultValue"><g:message code="field.defaultValue.label" default="Default Value" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'defaultValue', 'errors')}">
                                    <g:textField name="defaultValue" value="${fieldInstance?.defaultValue}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.defaultValue.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="label"><g:message code="field.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldInstance?.label}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.label.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="help"><g:message code="field.help.label" default="Help" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'help', 'errors')}">
                                    <g:textArea name="help" cols="40" rows="5" value="${fieldInstance?.help}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.help.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="alert"><g:message code="field.alert.label" default="Alert" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'alert', 'errors')}">
                                    <g:textArea name="alert" cols="40" rows="5" value="${fieldInstance?.alert}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.alert.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                  <label for="contentText"><g:message code="field.contentText.label" default="Content Text" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldInstance, field: 'contentText', 'errors')}">
                                    <g:textArea name="contentText" cols="40" rows="5" value="${fieldInstance?.contentText}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.contentText.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                            
 
                            
                        </tbody>
                    </table>
                    </div>
               
               <div id="advanced">
                    <table style="border:none;">
                        <tbody>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.minOccurs" default="Min Occurs" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "minOccurs")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.maxOccurs" default="Max Occurs" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "maxOccurs")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.nillable" default="Nillable" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${fieldInstance?.nillable}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.dependsOn" default="Depends On" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="field" action="show" id="${fieldInstance?.dependsOn?.id}">${fieldInstance?.dependsOn?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.dependencyType" default="Dependency Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "dependencyType")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.dependencyParameter" default="Dependency Parameter" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "dependencyParameter")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.customDependencyExpression" default="Custom Dependency Expression" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "customDependencyExpression")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.readonly" default="Readonly" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${fieldInstance?.readonly}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.securitylevelRead" default="Securitylevel Read" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "securitylevelRead")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.securitylevelReadWrite" default="Securitylevel Read Write" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "securitylevelReadWrite")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.fieldLength" default="Field Length" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "fieldLength")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.xpath" default="Xpath" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "xpath")}</td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                    </div>
                
               
               </div>
               
                
               