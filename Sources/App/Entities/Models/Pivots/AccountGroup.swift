//
//  AccountGroup.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import Vapor
import FluentMySQL

struct AccountGroup: Pivot {

    typealias Database = MySQLDatabase
    typealias ID = Int

    static var idKey: IDKey = \.id

    typealias Left = Account
    typealias Right = Group

    static var leftIDKey: LeftIDKey = \.accountId
    static var rightIDKey: RightIDKey = \.groupId

    var id: Int?
    var accountId: Int
    var groupId: Int
}

extension AccountGroup: ModifiablePivot {

    init(_ account: Account, _ group: Group) throws {
        accountId = try account.requireID()
        groupId = try group.requireID()
    }
}
