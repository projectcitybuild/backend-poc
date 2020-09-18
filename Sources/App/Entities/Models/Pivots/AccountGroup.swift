//
//  AccountGroup.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import Vapor
import FluentMySQLDriver

struct AccountGroup: Pivot {

    typealias Left = Account
    typealias Right = Group

    static var leftIDKey: LeftIDKey = \.accountId
    static var rightIDKey: RightIDKey = \.groupId

    var id: Int?
    var accountId: Int
    var groupId: Int
}

extension AccountGroup {

    typealias Database = MySQLDatabase
    typealias ID = Int

    static let entity = "accounts_groups"
    static var idKey: IDKey = \.id
}

extension AccountGroup {

    enum CodingKeys: String, CodingKey {
        case id = "account_group_id"
        case accountId = "account_id"
        case groupId = "group_id"
    }
}

extension AccountGroup: ModifiablePivot {

    init(_ account: Account, _ group: Group) throws {
        accountId = try account.requireID()
        groupId = try group.requireID()
    }
}

extension AccountGroup: MySQLMigration {

    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
        return MySQLDatabase.create(AccountGroup.self, on: connection) { (builder: SchemaCreator<AccountGroup>) in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.accountId)
            builder.field(for: \.groupId)
        }
    }
}
