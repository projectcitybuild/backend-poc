import Vapor
import FluentMySQL
import Authentication

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())

    try services.register(AuthenticationProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a MySQL database
    let mysql = MySQLDatabase(config: makeDatabaseConfig())

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: mysql, as: .mysql)
    databases.enableLogging(on: .mysql)
    services.register(databases)

    // Configure migrations
    let migrations = makeMigrationConfig()
    services.register(migrations)
}

private func makeDatabaseConfig() -> MySQLDatabaseConfig {
    return MySQLDatabaseConfig(
        hostname: Environment.get("MYSQL_HOST") ?? "127.0.0.1",
        port: Environment.get("MYSQL_PORT").flatMap { Int($0) } ?? 3306,
        username: Environment.get("MYSQL_USER") ?? "admin",
        password: Environment.get("MYSQL_PASS") ?? "root",
        database: Environment.get("MYSQL_DB") ?? "pcb_vapor"
    )
}

private func makeMigrationConfig() -> MigrationConfig {
    var migrations = MigrationConfig()

    migrations.add(model: Account.self, database: .mysql)
    migrations.add(model: AccountGroup.self, database: .mysql)
    migrations.add(model: Group.self, database: .mysql)
    migrations.add(model: MinecraftAuthCode.self, database: .mysql)
    migrations.add(model: MinecraftPlayer.self, database: .mysql)
    migrations.add(model: MinecraftPlayerAlias.self, database: .mysql)

    migrations.add(migration: SeedMigration.self, database: .mysql)

    return migrations
}
