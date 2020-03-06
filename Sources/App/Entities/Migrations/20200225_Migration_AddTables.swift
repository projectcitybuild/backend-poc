//
//  0001_Migration_AddTables.swift
//  App
//
//  Created by Andy Saw on 2020/02/25.
//

import FluentMySQL

//struct Migration_20200225_AddTables: MySQLMigration {
//
//    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return MySQLDatabase.create(Account.self, on: connection) { (builder: SchemaCreator<Account>) in
//            builder.field(for: \.id, isIdentifier: true)
//            builder.field(for: \.email, type: .varchar)
//            builder.field(for: \.username, type: .varchar)
//            builder.field(for: \.password, type: .varchar)
//            builder.field(for: \.lastLoginIp, type: .varchar)
//            builder.field(for: \.lastLoginAt, type: .datetime)
//            builder.field(for: \.createdAt, type: .datetime)
//            builder.field(for: \.updatedAt, type: .datetime)
//        }
//    }
//
//    static func revert(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return MySQLDatabase.delete(Account.self, on: connection)
//    }
//}
