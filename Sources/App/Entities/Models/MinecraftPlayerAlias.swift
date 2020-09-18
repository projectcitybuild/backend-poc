//
//  MinecraftPlayerAlias.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import Vapor
import FluentMySQLDriver

final class MinecraftPlayerAlias: Model {

    @ID(key: "player_minecraft_alias_id")
    var id: Int?

    @Field(key: "player_minecraft_id")
    var minecraftPlayerId: Int

    @Field(key: "alias")
    var alias: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
}

extension MinecraftPlayerAlias {

    static let schema = "players_minecraft_aliases"
}

/// Allows `MinecraftPlayerAlias` to be encoded to and decoded from HTTP messages.
extension MinecraftPlayerAlias: Content {}


//extension MinecraftPlayerAlias: MySQLMigration {
//
//    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return MySQLDatabase.create(MinecraftPlayerAlias.self, on: connection) { (builder: SchemaCreator<MinecraftPlayerAlias>) in
//            builder.field(for: \.id, isIdentifier: true)
//            builder.field(for: \.minecraftPlayerId)
//            builder.field(for: \.alias)
//            builder.field(for: \.createdAt)
//            builder.field(for: \.updatedAt)
//        }
//    }
//}
