//
//  Account.swift
//  App
//
//  Created by Andy Saw on 2020/02/25.
//

import Vapor
import FluentMySQLDriver

struct Account: Model {

    @ID(key: "account_id")
    var id: Int?

    @Field(key: "email")
    var email: String

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @Field(key: "last_login_ip")
    var lastLoginIp: String?

    @Field(key: "last_login_at")
    var lastLoginAt: Date?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
}

extension Account {

    static let schema = "accounts"
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


//extension Account: MySQLMigration {
//
//    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return MySQLDatabase.create(Account.self, on: connection) { (builder: SchemaCreator<Account>) in
//            builder.field(for: \.id, isIdentifier: true)
//            builder.field(for: \.email)
//            builder.field(for: \.username)
//            builder.field(for: \.password)
//            builder.field(for: \.lastLoginIp)
//            builder.field(for: \.lastLoginAt)
//            builder.field(for: \.createdAt)
//            builder.field(for: \.updatedAt)
//        }
//    }
//}
