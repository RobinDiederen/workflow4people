class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
	  
	  /*
	  "/" {
		  controller=""
	      action="auth"
	  }
*/
	  /*
	  "400"(controller:"error",action: "error") // bad request
	  "401"(controller:"error",action: "unauthorized") // unauthorized
	  "403"(controller:"error",action: "error") // forbidden
	  "404"(controller:"error",action: "error") // not found
	  "405"(controller:"error",action: "error") // method not allowed
	  "406"(controller:"error",action: "error") // not acceptable
	  "408"(controller:"error",action: "error") // request timeout
	  "500"(controller:"error",action: "error") // internal server error
	  "501"(controller:"error",action: "error") // not implemented
	  "503"(controller:"error",action: "error") // service unavailable
	  */
	}
}
