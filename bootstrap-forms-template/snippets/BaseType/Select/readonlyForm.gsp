<%-- TODO change this into a more efficient solution to look up the label - put it in the forms taglib --%>

<g:each in="${org.workflow4people.FieldTypeItem.findAllByFieldType(field.fieldType,[sort:'position',order:'asc'])}" var="item" >
  <f:if test="*{'${item.value}'==document.${gpath}.text()}">
  ${item.label}
  </f:if>  
  </g:each>