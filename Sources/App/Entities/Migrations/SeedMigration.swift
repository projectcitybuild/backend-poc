//
//  SeedMigration.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import FluentMySQLDriver

/// Populates the database with some initial data
struct SeedMigration: Migration {

    typealias Database = MySQLDatabase

    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        database.withConnection { $0.seedGroups() }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {

    }
//    func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return seedGroups(on: connection)
//    }
//
//    func revert(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return Group.query(on: connection).delete()
//    }
}

fileprivate extension MySQLConnection {

    func seedGroups() -> EventLoopFuture<Void> {
//        let group1 = Group(name: "administrator", alias: "Admin", discourseName: "administrator", isDefault: false, isStaff: true, isAdmin: true)
//        let group2 = Group(name: "senior operator", alias: "SOP", discourseName: "senior-operator", isDefault: false, isStaff: true, isAdmin: false)
//        let group3 = Group(name: "operator", alias: "OP", discourseName: "operator", isDefault: false, isStaff: true, isAdmin: false)
//        let group4 = Group(name: "moderator", alias: "Mod", discourseName: "moderator", isDefault: false, isStaff: true, isAdmin: false)
//        let group5 = Group(name: "donator", alias: "Donator", discourseName: "donator", isDefault: false, isStaff: false, isAdmin: false)
//        let group6 = Group(name: "trusted plus", alias: "Trusted+", discourseName: "trusted-plus", isDefault: false, isStaff: false, isAdmin: false)
//        let group7 = Group(name: "trusted", alias: "Trusted", discourseName: "trusted", isDefault: false, isStaff: false, isAdmin: false)
//        let group8 = Group(name: "member", alias: "Member", discourseName: nil, isDefault: true, isStaff: false, isAdmin: false)
//        let group9 = Group(name: "retired", alias: "Retired", discourseName: "retired", isDefault: false, isStaff: false, isAdmin: false)
//
//        return group1.save(on: connection)
//            .and(group2.save(on: connection))
//            .and(group3.save(on: connection))
//            .and(group4.save(on: connection))
//            .and(group5.save(on: connection))
//            .and(group6.save(on: connection))
//            .and(group7.save(on: connection))
//            .and(group8.save(on: connection))
//            .and(group9.save(on: connection))
//            .transform(to: ())
    }
}
