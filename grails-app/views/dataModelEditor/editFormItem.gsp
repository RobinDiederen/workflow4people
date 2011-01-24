 <div id="dialog" title="Edit form item">
	<form id="ajaxdialogform">			 		
	                <g:hiddenField name="id" value="${formItem?.id}" />
                <g:hiddenField name="version" value="${formItem?.version}" />
                    <table style="border:none;">
                        <tbody>
                        
                         <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="position"><g:message code="formItem.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formItemInstance, field: 'position', 'errors')}">
                                    ${fieldValue(bean: formItemInstance, field: 'position')}&nbsp;<a tabindex="9999" class="awesome small blue help button" title="${message(code:'formItem.position.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                                                
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="baseXpath"><g:message code="formItem.snippet.label" default="Snippet" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: formItemInstance, field: 'snippet', 'errors')}">
                                    <g:textField name="snippet" value="${formItemInstance?.snippet}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'formItem.snippet.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="readonly"><g:message code="formItem.readonly.label" default="Readonly" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formItemInstance, field: 'readonly', 'errors')}">
                                    <g:checkBox name="readonly" value="${formItemInstance?.readonly}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'formItem.readonly.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
            
               
            
          </form>     
</div> 
               