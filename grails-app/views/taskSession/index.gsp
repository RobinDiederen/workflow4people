<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <title>Existing task sessions</title>
  
  <g:javascript src="jquery/jquery-1.4.2.js" plugin="wfp"/>        
  <jqui:resources theme="smoothness" />
  <g:javascript src="jquery/jquery.timers-1.2.js"  contextPath="" plugin="wfp"/>
  <g:javascript src="jquery/jquery.cluetip-patched.js"  contextPath="" plugin="wfp"/>
  <g:javascript src="jquery/jquery.dataTables.js"  contextPath="" plugin="wfp"/>
  <g:javascript src="jquery/jquery.validate.pack.js"  contextPath="" plugin="wfp"/>
  <g:javascript src="jquery/datePicker/jquery.ui.datepicker-${java.util.Locale.getDefault().getLanguage()}.js" contextPath="" plugin="wfp"/>
  <g:javascript src="jquery/jquery.inputmask.js"  contextPath="" plugin="wfp"/>
  <g:javascript src="jquery/jquery.blockUI.js"  contextPath="" plugin="wfp" />
  <g:javascript src="wfp-forms.js"  contextPath="" plugin="wfp"/>
  <g:javascript src="jquery/jquery.gritter.js" plugin="wfp"/>

</head>
<body>
  <div class="body">
   
  <g:javascript>  
    $(document).ready(function() {
    $('#example').dataTable( {
        "bProcessing": true,
        "bServerSide": true,
        "sAjaxSource": "../server_side/scripts/server_processing.php"
    } );
	} );
  </g:javascript>    
    
  </div>
</body>
</html>
