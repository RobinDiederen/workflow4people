modules = {
	wfp {
		dependsOn 'dialog,dialog-tree,dialog-dataTables,dialog-altselect,dialog-codemirror,bootstrap-css,bootstrap-tooltip,bootstrap-popover,bootstrap-modal,dialog-bootstrap,dialog-fileuploader,dialog-last'		
		
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
		//resource url:'js/jquery/jquery.jstree.js'
		resource url:'js/jquery/jquery.timers-1.2.js'		
		resource url:'js/dme/editor.js'
		
	}
	
	'wfp-tree' {
		dependsOn 'wfp,dialog-tree'
		resource url:'css/tree/tree.css'
		resource url:'js/tree/tree.js'
		resource url:'js/jquery/jquery.hotkeys.js'
		resource url:'js/jquery/jquery.cookie.js'
	}
	
	
}