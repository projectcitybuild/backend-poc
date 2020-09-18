import Vapor
import FluentMySQLDriver

/// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Register middleware
    // app.middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    app.middleware.use(ErrorMiddleware.default(environment: app.environment)) // Catches errors and converts to HTTP response

    // Configure a MySQL database
    let mysqlConfig = DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("MYSQL_HOST") ?? "127.0.0.1",
        port: Environment.get("MYSQL_PORT").flatMap { Int($0) } ?? 3306,
        username: Environment.get("MYSQL_USER") ?? "admin",
        password: Environment.get("MYSQL_PASS") ?? "root",
        database: Environment.get("MYSQL_DB") ?? "pcb_vapor"
    )
    app.databases.use(mysqlConfig, as: .mysql)

    app.migrations.add(SeedMigration())

    try routes(app)
}

//fileprivate func makeMigrationConfig() -> MigrationConfig {
//    var migrations = MigrationConfig()
//
//    migrations.add(model: Account.self, database: .mysql)
//    migrations.add(model: AccountGroup.self, database: .mysql)
//    migrations.add(model: Group.self, database: .mysql)
//    migrations.add(model: MinecraftAuthCode.self, database: .mysql)
//    migrations.add(model: MinecraftPlayer.self, database: .mysql)
//    migrations.add(model: MinecraftPlayerAlias.self, database: .mysql)
//
//    migrations.add(migration: SeedMigration.self, database: .mysql)
//
//    return migrations
//}
