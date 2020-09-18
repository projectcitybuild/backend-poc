//
//  MinecraftAuthCode.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import Vapor
import FluentMySQLDriver

struct MinecraftAuthCode: Model {

    @ID(key: "minecraft_auth_code_id")
    var id: Int?

    @Field(key: "uuid")
    var uuid: String

    @Field(key: "token")
    var token: String

    @Field(key: "player_minecraft_id")
    var minecraftPlayerId: Int

    @Field(key: "expires_At")
    var expiresAt: Date
}

extension MinecraftAuthCode {

    static let schema = "minecraft_auth_codes"
}

extension MinecraftAuthCode {

    var minecraftPlayer: Parent<MinecraftAuthCode, MinecraftPlayer> {
        return parent(\.minecraftPlayerId)
    }
}

/// Allows `MinecraftAuthCode` to be encoded to and decoded from HTTP messages.
extension MinecraftAuthCode: Content {}


//extension MinecraftAuthCode: MySQLMigration {
//
//    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return MySQLDatabase.create(MinecraftAuthCode.self, on: connection) { (builder: SchemaCreator<MinecraftAuthCode>) in
//            builder.field(for: \.id, isIdentifier: true)
//            builder.field(for: \.uuid)
//            builder.field(for: \.token)
//            builder.field(for: \.minecraftPlayerId)
//            builder.field(for: \.expiresAt)
//        }
//    }
//}

extension MinecraftAuthCode: ModelResourceConvertible {

    struct Resource: ModelResource {
        var id: Int?
        var uuid: String
        var token: String
        var minecraftPlayerId: Int
        var expiresAt: Date

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case uuid = "uuid"
            case token = "token"
            case minecraftPlayerId = "minecraft_player_id"
            case expiresAt = "expires_at"
        }

        init(rawModel model: MinecraftAuthCode) {
            self.id = model.id
            self.uuid = model.uuid
            self.token = model.token
            self.minecraftPlayerId = model.minecraftPlayerId
            self.expiresAt = model.expiresAt
        }
    }
}
