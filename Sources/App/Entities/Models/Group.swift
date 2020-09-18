//
//  Group.swift
//  App
//
//  Created by Andy Saw on 2020/02/25.
//

import Vapor
import FluentMySQLDriver

final class Group: Model {

    @ID(key: "group_id")
    var id: Int?

    @Field(key: "name")
    var name: String

    @Field(key: "alias")
    var alias: String

    @Field(key: "discourse_name")
    var discourseName: String?

    @Field(key: "is_default")
    var isDefault: Bool

    @Field(key: "is_staff")
    var isStaff: Bool

    @Field(key: "is_admin")
    var isAdmin: Bool
}

extension Group {

    static let schema = "groups"
}

/// Allows `Group` to be encoded to and decoded from HTTP messages.
extension Group: Content {}

/// Allows `Group` to be used as a dynamic parameter in route definitions.
extension Group: Parameter {}


//extension Group: MySQLMigration {
//
//    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
//        return MySQLDatabase.create(Group.self, on: connection) { (builder: SchemaCreator<Group>) in
//            builder.field(for: \.id, isIdentifier: true)
//            builder.field(for: \.name)
//            builder.field(for: \.alias)
//            builder.field(for: \.discourseName)
//            builder.field(for: \.isDefault)
//            builder.field(for: \.isStaff)
//            builder.field(for: \.isAdmin)
//        }
//    }
//}
