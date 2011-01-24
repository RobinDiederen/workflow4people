			 <div id="dialog" title="Edit fieldlist">
					
						<form id="ajaxdialogform">
					
					
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="parent"><g:message code="fieldList.parent.label" default="Parent" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldListInstance, field: 'parent', 'errors')}">
                                    <g:select name="parent.id" from="${org.workflow4people.Field.findAll([sort:'name',order:'asc'])}" optionKey="id" value="${fieldListInstance?.parent?.id}" noSelection="['null': '']" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.parent.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="fieldList.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldListInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldListInstance?.name}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="namespace"><g:message code="fieldList.namespace.label" default="Namespace" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldListInstance, field: 'namespace', 'errors')}">
                                    <g:select name="namespace.id" from="${org.workflow4people.Namespace.findAll([sort:'prefix',order:'asc'])}" optionKey="id" value="${fieldListInstance?.namespace?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.namespace.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="baseType"><g:message code="fieldList.baseType.label" default="Base Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldListInstance, field: 'baseType', 'errors')}">
                                    <g:select name="baseType.id" from="${org.workflow4people.BaseType.findAll([sort:'name',order:'asc'])}" optionKey="id" value="${fieldListInstance?.baseType?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.baseType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="label"><g:message code="fieldList.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldListInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldListInstance?.label}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.label.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="fieldList.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldListInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${fieldListInstance?.description}" />

                                                                        
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                    
                    
               
             
                
               
     
               </form>
               </div>
                
               