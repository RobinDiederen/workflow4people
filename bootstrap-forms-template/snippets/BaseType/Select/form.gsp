<%
def fieldTypeItems = org.workflow4people.FieldTypeItem.findAllByFieldType(field.fieldType,[sort:'position',order:'asc'])

def options = "["
for (def fieldTypeItem in fieldTypeItems) {
    if (!(fieldTypeItems.get(0) == fieldTypeItem)) {
        options = options + ", "
    }
    options = "${options}'${fieldTypeItem.value.replaceAll("'", "\\\\'")}':'${fieldTypeItem.label.replaceAll("'", "\\\\'")}'"
}
options = "${options}]"
%>

<form:select class="${field.nillable ? '' : 'required'} fieldtype-${fieldTypeName} field-${name}" gpath="document.${gpathExpr}" options="${options}" value="*{document.${gpath}}" helpTitle="${label}" helpBody="${help}" title="${alert}" />
