<w:snippet type="Default" name="labelwrapper" label="Aanvrager" >
*{document.${formItem.field.gpath}.user.displayName.text()} (*{document.${formItem.field.gpath}.user.name.text()})
</w:snippet>

<w:snippet type="Default" name="labelwrapper" label="E-mail" >
*{document.${formItem.field.gpath}.user.email.text()}
</w:snippet>
