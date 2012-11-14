			<!-- Authentication from snippet -->
			<xforms:instance id="formAuthAccessRequest">
	                <parameters:access-parameters xmlns="http://www.open-t.nl/schemas/parameters" xmlns:parameters="http://www.open-t.nl/schemas/parameters">
	                    <user></user>	                    
	                 	<workflow>${form.workflow.name}</workflow>
	                 	<form>${form.name}</form>
	                 	<document></document>
	                 	<action>${form.formAction.name}</action>
	              	</parameters:access-parameters>
	        </xforms:instance>
	        
	        <xforms:instance id="formAuthAccessResponse" src="oxf:/workflow4people/xml/has-access-to-form-response.xml"/>
			<xforms:instance id="userDetails"><dummy/></xforms:instance>	            		
    		<xforms:action ev:event="xforms-ready">
    			<xforms:insert nodeset="instance('formAuthAccessResponse')" origin="xxforms:call-xpl('oxf:/workflow4people/xpl/form-access.xpl','data',(instance('formAuthAccessRequest')),'data')" />
    			<xforms:insert nodeset="instance('userDetails')" origin="xxforms:call-xpl('oxf:/workflow4people/xpl/user-details.xpl',(),(),'data')" />    			
    			<xforms:setvalue ref="instance('document-instance')//doc:header/doc:user/doc:name" value="instance('userDetails')//ser:userDetails/ser:name" />
    			<xforms:setvalue ref="instance('document-instance')//doc:header/doc:user/doc:displayName" value="instance('userDetails')//ser:userDetails/ser:realName" />
    			<xforms:setvalue ref="instance('document-instance')//doc:header/doc:user/doc:email" value="instance('userDetails')//ser:userDetails/ser:email" />
			</xforms:action>
    		
			<xforms:action ev:event="xforms-ready" if="instance('formAuthAccessResponse')/ser:access=true()">
	 			<xforms:toggle case="hasAccess"></xforms:toggle>
			</xforms:action>