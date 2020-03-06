//
//  AccountController.swift
//  App
//
//  Created by Andy Saw on 2020/03/06.
//

import Vapor
import FluentMySQL

final class AccountController {

    func create(_ request: Request) throws -> Future<Account> {
         struct RequestBody: Content {
            let email: String
            let username: String
            let password: String
        }

        return try request.content.decode(RequestBody.self).flatMap { requestBody in
            let validation = Account.query(on: request)
                .filter(\.email, .equal, requestBody.email)
                .filter(\.username, .equal, requestBody.username)
                .first()
                .map { account -> Void in
                    if let account = account {
                        if account.email == requestBody.email {
                            throw CustomHttpError(status: .badRequest, reason: "This email address is already in use", identifier: "email_taken")
                        }
                        if account.username == requestBody.username {
                            throw CustomHttpError(status: .badRequest, reason: "This username is already in use", identifier: "username_taken")
                        }
                        // TODO: log this
                        throw CustomHttpError(status: .internalServerError, reason: "Account already exists", identifier: "matching_account_found")
                    }
                    return ()
                }

            return validation.then { _ in
                return request.transaction(on: .mysql) { connection in
                    let account = Account(
                        email: requestBody.email,
                        username: requestBody.username,
                        password: requestBody.password,
                        lastLoginIp: request.http.remotePeer.hostname,
                        lastLoginAt: nil,
                        createdAt: Date(),
                        updatedAt: Date()
                    )
                    return account.create(on: connection).flatMap { account in

                        // Attach default group to user
                        return Group.query(on: connection).filter(\.isDefault, .equal, true).first()
                            .flatMap { group -> EventLoopFuture<AccountGroup> in
                                guard let group = group else {
                                    // TODO: log this
                                    throw CustomHttpError(status: .internalServerError, reason: "No default group available", identifier: "no_default_group_set")
                                }
                                return account.groups.attach(group, on: connection)
                            }
                            .map { _ in account }
                    }
                }
            }
        }
    }

//    func delete(_ request: Request) throws -> Future<HTTPStatus> {
//        return try req.parameters.next(Todo.self).flatMap { todo in
//            return todo.delete(on: req)
//        }.transform(to: .ok)
//    }
}
