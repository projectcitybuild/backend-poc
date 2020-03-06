//
//  Account.swift
//  App
//
//  Created by Andy Saw on 2020/02/25.
//

import Vapor
import FluentMySQL
import Authentication

struct Account: MySQLModel {

    /// The unique identifier for this `Account`.
    var id: Int?

    var email: String

    var username: String

    var password: String

    var lastLoginIp: String?

    var lastLoginAt: Date?

    var createdAt: Date?

    var updatedAt: Date?
}

extension Account {

    static let entity = "accounts"

    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt
}

extension Account {

    enum CodingKeys: String, CodingKey {
        case id = "account_id"
        case email = "email"
        case username = "username"
        case password = "password"
        case lastLoginIp = "last_login_ip"
        case lastLoginAt = "last_login_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension Account {

    /// All the groups that this account belongs to
    var groups: Siblings<Account, Group, AccountGroup> {
        return siblings()
    }

    /// This account's Minecraft account, if linked
    var minecraftPlayer: Children<Account, MinecraftPlayer> {
        return children(\.accountId)
    }
}

/// Allows `Account` to be used in authentication
extension Account: PasswordAuthenticatable {

    static var usernameKey: UsernameKey = \.email
    static var passwordKey: PasswordKey = \.password
}

/// Allows `Account` to be encoded to and decoded from HTTP messages.
extension Account: Content {}

/// Allows `Account` to be used as a dynamic parameter in route definitions.
extension Account: Parameter {}


extension Account: MySQLMigration {

    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
        return MySQLDatabase.create(Account.self, on: connection) { (builder: SchemaCreator<Account>) in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.email)
            builder.field(for: \.username)
            builder.field(for: \.password)
            builder.field(for: \.lastLoginIp)
            builder.field(for: \.lastLoginAt)
            builder.field(for: \.createdAt)
            builder.field(for: \.updatedAt)
        }
    }
}
