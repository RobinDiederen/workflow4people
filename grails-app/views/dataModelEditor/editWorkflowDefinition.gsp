 <div id="dialog" title="Workflow definition">
	<form id="ajaxdialogform" style="width:600px;">			 		
	                <g:hiddenField name="id" value="${workflowDefinitionInstance?.id}" />
                <g:hiddenField name="version" value="${workflowDefinition?.version}" />
                    <table style="border:none;">
                        <tbody>
                        
                       <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="publish"><g:message code="workflowDefinition.publish.label" default="Publish" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'publish', 'errors')}">
                                    <g:checkBox name="publish" value="${workflowDefinitionInstance?.publish}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowDefinition.publish.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="workflowDefinition.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: workflowDefinitionInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${workflowDefinitionInstance?.name}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowDefinition.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="workflowDefinition.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: workflowDefinitionInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${workflowDefinitionInstance?.title}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowDefinition.title.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="workflowDefinition.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${workflowDefinitionInstance?.description}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowDefinition.description.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        <g:if test="${workflowDefinitionInstance?.id}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateCreated"><g:message code="workflowDefinition.dateCreated.label" default="Date Created" /></label>
                                </td>
                                <td valign="top" class="value">
                                    ${formatDate(date:workflowDefinitionInstance?.dateCreated,format:"yyyy-MM-dd'T'HH:mm:ss")}&nbsp;
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowDefinition.dateCreated.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastUpdated"><g:message code="workflowDefinition.lastUpdated.label" default="Last Updated" /></label>
                                </td>
                                <td valign="top" class="value">
                                    ${formatDate(date:workflowDefinitionInstance?.lastUpdated,format:"yyyy-MM-dd'T'HH:mm:ss")}&nbsp;<a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowDefinition.lastUpdated.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        </g:if>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentType"><g:message code="workflowDefinition.documentType.label" default="Document Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'documentType', 'errors')}">
                                    <g:select name="documentType.id" from="${org.workflow4people.DocumentType.findAll([sort:'name',order:'asc'])}" optionKey="id" value="${workflowDefinitionInstance?.documentType?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowDefinition.documentType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
 
                            
                        </tbody>
                    </table>
            
               
            
          </form>     
</div> 
               