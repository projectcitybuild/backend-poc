//
//  Group.swift
//  App
//
//  Created by Andy Saw on 2020/02/25.
//

import Vapor
import FluentMySQL

struct Group: MySQLModel {

    var id: Int?

    var name: String

    var alias: String

    var discourseName: String

    var isDefault: Bool

    var isStaff: Bool

    var isAdmin: Bool
}

extension Group {

    static let entity = "groups"
}

extension Group {

    enum CodingKeys: String, CodingKey {
        case id = "group_id"
        case name = "name"
        case alias = "alias"
        case discourseName = "discourse_name"
        case isDefault = "is_default"
        case isStaff = "is_staff"
        case isAdmin = "is_admin"
    }
}

/// Allows `Group` to be encoded to and decoded from HTTP messages.
extension Group: Content {}

/// Allows `Group` to be used as a dynamic parameter in route definitions.
extension Group: Parameter {}
