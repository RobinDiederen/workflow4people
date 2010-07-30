					
					
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
						<g:hiddenField name="detailType" value="show"/>
						<g:hiddenField name="detailClass" value="Field"/>					
						<g:hiddenField name="detailId" value="${fieldInstance.id}"/>
                    <table style="border:none;">
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.id" default="Id" />:</td>
                                
                                <td valign="top" class="value" id="id">${fieldValue(bean: fieldInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.fieldPosition" default="Field Position" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "fieldPosition")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.fieldType" default="Field Type" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="fieldType" action="show" id="${fieldInstance?.fieldType?.id}">${fieldInstance?.fieldType?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.childFieldList" default="Child Field List" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="fieldList" action="show" id="${fieldInstance?.childFieldList?.id}">${fieldInstance?.childFieldList?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.fieldList" default="Field List" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="fieldList" action="show" id="${fieldInstance?.fieldList?.id}">${fieldInstance?.fieldList?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.defaultValue" default="Default Value" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "defaultValue")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.label" default="Label" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "label")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.help" default="Help" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "help")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.alert" default="Alert" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "alert")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.contentText" default="Content Text" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "contentText")}</td>
                                
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
                                <td valign="top" class="name"><g:message code="field.dependencyExpression" default="Dependency Expression" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "dependencyExpression")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="field.readonly" default="Readonly" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${fieldInstance?.readonly}" /></td>
                                
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
               
                
               