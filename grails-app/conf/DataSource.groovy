	hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true    
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
    max_fetch_depth=5
}

// environment specific settings
environments {
	development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url="jdbc:mysql://localhost/wf4p_24052011"
    		username = "dev"
    		password = "dev"
        } 
	production {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url="jdbc:mysql://localhost/wf4p_24052011"
    		username = "dev"
    		password = "dev"
        } 
	}
}
}
