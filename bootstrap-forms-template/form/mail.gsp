<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:w="w" xmlns:f="f" xmlns:g="g" xmlns:mail="mail">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title>${form.title}</title>
    </head>
  <body>
    <mmail:form action="submit" title="" explanation="${form.explanationMessage}" name="request" process="${form.workflow.name}">
      <table>
        <w:formItems form="${form}" var="formItem">			 	        		        	
      		<tr>
      		  <td colspan="2">&nbsp;<td>
      		</tr>
      		<g:if test="${formItem.field.binding.label.length() > 0}">
        		<tr class="section-head">
        		  <td colspan="2"><b>${formItem.field.binding.label}</b></td>
        		</tr>
      		</g:if>			 	
          <w:snippet var="${formItem}" name="${formItem.snippet}" model="${[readonly:true, mail:true]}"/>
        </w:formItems>
    		<tr>
    		  <td colspan="2">&nbsp;<td>
    		</tr>
    		<tr class="section-head">
    		  <td colspan="2">*{g.message(code: 'comment')}</td>
    		</tr>
        <w:snippet type="Form" name="mailComment" />
      </table>
    </mmail:form>
  </body>
</html>
