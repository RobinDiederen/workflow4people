modules = {
	wfp {
		dependsOn 'dialog,dialog,dialog-dataTables,dialog-altselect,dialog-codemirror,bootstrap-responsive-css,bootstrap-tooltip,bootstrap-popover,bootstrap-modal,dialog-bootstrap,dialog-fileuploader'		
		
		//resource url:'/css/workflow4people.css'
		//resource url:'/css/theme/roller-theme.css'
		resource url:'/css/theme/theme.css'
		resource url:'/images/favicon.ico'
		
		resource url:'js/jquery/localisation/jquery.localisation-min.js'
		resource url:'js/workflow4people.js'
		
	}
	
	dme {
		dependsOn 'wfp'
		resource url:'/css/jquery.treeview.css'
		resource url:'/css/dme/jquery.jstree.css'
		resource url:'/css/dme/editor.css'
		
		resource url:'js/jquery/jquery.cookie.js'
		resource url:'js/jquery/jquery.hotkeys.js'
		resource url:'js/jquery/jquery.jstree.js'
		resource url:'js/jquery/jquery.cookie.js'
		resource url:'js/dme/editor.js'
		
	}
	
	
}