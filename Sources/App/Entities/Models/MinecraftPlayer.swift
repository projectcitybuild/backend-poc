//
//  MinecraftPlayer.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import Vapor
import FluentMySQL

struct MinecraftPlayer: MySQLModel {

    var id: Int?

    var uuid: String

    var accountId: Int?

    var playtime: Int

    var lastSeenAt: Date
}

extension MinecraftPlayer {

    static let entity = "players_minecraft"
}

extension MinecraftPlayer {

    enum CodingKeys: String, CodingKey {
        case id = "player_minecraft_id"
        case uuid = "uuid"
        case accountId = "account_id"
        case playtime = "playtime"
        case lastSeenAt = "last_seen_at"
    }
}

extension MinecraftPlayer {

    /// The PCB account this Minecraft player belongs to (can only be one at most)
    var account: Parent<MinecraftPlayer, Account>? {
        return parent(\.accountId)
    }

    /// All the aliases that belong to this player. If a player has never changed their alias,
    /// they will have just one alias.
    var aliases: Children<MinecraftPlayer, MinecraftPlayerAlias> {
        return children(\.minecraftPlayerId)
    }
}

/// Allows `MinecraftPlayer` to be encoded to and decoded from HTTP messages.
extension MinecraftPlayer: Content {}

/// Allows `MinecraftPlayer` to be used as a dynamic parameter in route definitions.
extension MinecraftPlayer: Parameter {}
