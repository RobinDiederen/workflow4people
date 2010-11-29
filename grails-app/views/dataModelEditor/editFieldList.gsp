			 <div id="dialog" title="Edit fieldlist">
					
						<form id="ajaxdialogform">
					
					<div id="dialogtabs" style="border:none;"> 
					<ul>						
							<li>
								<a href="#details">Details</a>
							</li>
						
						
						
					</ul>
					
					<div id="details">
					<g:hiddenField name="detailType" value="show"/>
					<g:hiddenField name="detailClass" value="FieldList"/>					
					<g:hiddenField name="detailId" value="${fieldListInstance.id}"/>
					
                     <table style="border:none">
                    <tbody>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@11e44f0[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="fieldList.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldListInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">                        
                            <td valign="top" class="name">
                            	<g:message code="fieldList.name.label" default="Name" />
                           	</td>
                            <td valign="top" class="value null">
                         		<g:textField name="name" value="${fieldListInstance?.name}" />
								<a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.name.help',default:'x')}" href="" >?</a>
                            </td>                            
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@438e9e9[name=namespace,type=class org.workflow4people.Namespace,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3484c229[class org.workflow4people.FieldList,namespace,class org.workflow4people.Namespace,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@77e72cae[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.namespace.label" default="Namespace" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="namespace" action="show" id="${fieldListInstance?.namespace?.id}">${fieldListInstance?.namespace?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7ff5376c[name=baseType,type=class org.workflow4people.BaseType,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3c09d515[class org.workflow4people.FieldList,baseType,class org.workflow4people.BaseType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2984747e[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.baseType.label" default="Base Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="baseType" action="show" id="${fieldListInstance?.baseType?.id}">${fieldListInstance?.baseType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@36fc117d[name=label,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5ee041be[class org.workflow4people.FieldList,label,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@54fc519b[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldListInstance, field: "label")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@151c2b4[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1ec5b819[class org.workflow4people.FieldList,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@46b98117[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@3cca3147[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldListInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
                    </div>
               
             
                
               
               </div>
               </form>
               </div>
                
               