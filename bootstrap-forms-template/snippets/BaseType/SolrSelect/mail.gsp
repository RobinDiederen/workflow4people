<g:each in="${org.workflow4people.FieldTypeItem.findAllByFieldType(field.fieldType,[sort:'position',order:'asc'])}" var="item" >
  <f:if test="*{'${item.value}'==document.${gpath}.text()}">
    <mmail:output type="text" value="${item.label}" />
  </f:if>  
</g:each>
