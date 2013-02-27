dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
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
            jndiName = "java:comp/env/jdbc/wf4p"

            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

        } 

    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:devDb"
        }
    }
    production {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            jndiName = "java:comp/env/jdbc/wf4p"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
        }
    }
}
