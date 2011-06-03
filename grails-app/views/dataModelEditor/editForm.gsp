 <div id="dialog" title="Edit form">
	<form id="ajaxdialogform">			 		
	                <g:hiddenField name="id" value="${formInstance?.id}" />
                <g:hiddenField name="version" value="${formInstance?.version}" />
                    <table style="border:none;">
                        <tbody>
                        
                           <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="form.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: formInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${formInstance?.name}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="form.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: formInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${formInstance?.title}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.title.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="form.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${formInstance?.description}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.description.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="explanationMessage"><g:message code="form.explanationMessage.label" default="Explanation Message" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formInstance, field: 'explanationMessage', 'errors')}">
                                    <g:textArea name="explanationMessage" cols="40" rows="5" value="${formInstance?.explanationMessage}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.explanationMessage.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="confirmationMessage"><g:message code="form.confirmationMessage.label" default="Confirmation Message" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formInstance, field: 'confirmationMessage', 'errors')}">
                                    <g:textArea name="confirmationMessage" cols="40" rows="5" value="${formInstance?.confirmationMessage}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.confirmationMessage.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="template"><g:message code="form.template.label" default="Template" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: formInstance, field: 'template', 'errors')}">
                                    <%-- <g:textField name="template" value="${formInstance?.template}" /> --%>
                                    <g:select name="template" from="${formTemplateNames}" value="${formInstance?.template}"  />
                                    

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.template.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="formAction"><g:message code="form.formAction.label" default="Form Action" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formInstance, field: 'formAction', 'errors')}">
                                    <g:select name="formAction.id" from="${org.workflow4people.Action.findAll([sort:'name',order:'asc'])}" optionKey="id" value="${formInstance?.formAction?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.formAction.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
 
                            
                        </tbody>
                    </table>
            
               
            
          </form>     
</div> 
               