dataSource {
    pooled = true
    driverClassName = "org.hsqldb.jdbcDriver"
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

            dialect = "org.hibernate.dialect.MySQLInnoDBDialect"

        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:mem:testDb"
        }
    }
    production {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            jndiName = "java:comp/env/jdbc/wf4p"
            dialect = "org.hibernate.dialect.MySQLInnoDBDialect"
        }
    }
}
