//
//  MinecraftPlayerAlias.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import Vapor
import FluentMySQL

struct MinecraftPlayerAlias: MySQLModel {

    var id: Int?

    var minecraftPlayerId: Int

    var alias: String

    var createdAt: Date?

    var updatedAt: Date?
}

extension MinecraftPlayerAlias {

    static let entity = "players_minecraft_aliases"

    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt
}

extension MinecraftPlayerAlias {

    enum CodingKeys: String, CodingKey {
        case id = "player_minecraft_alias_id"
        case minecraftPlayerId = "player_minecraft_id"
        case alias = "alias"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

/// Allows `MinecraftPlayerAlias` to be encoded to and decoded from HTTP messages.
extension MinecraftPlayerAlias: Content {}
