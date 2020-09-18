//
//  PlayerAuthenticateController.swift
//  App
//
//  Created by Andy Saw on 2020/02/26.
//

import Vapor
import FluentMySQLDriver

final class PlayerAuthenticateController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let authenticate = routes.grouped("authenticate", "minecraft")
        authenticate.post(use: get)
    }

    func get(request: Request) throws -> EventLoopFuture<MinecraftAuthCode.Resource> {
        struct RequestBody: Content {
            let minecraftUUID: String

            enum CodingKeys: String, CodingKey {
                case minecraftUUID = "minecraft_uuid"
            }
        }

        let body = try request.content.decode(RequestBody.self)
        let uuid = body.minecraftUUID.replacingOccurrences(of: "-", with: "")

        // TODO: query Mojang API for UUID existence first
        return MinecraftPlayer.getOrCreate(
                request: request,
                uuid: uuid,
                modelToCreate: MinecraftPlayer(uuid: uuid, accountId: nil, playtime: 0, lastSeenAt: Date())
            )
            .flatMap { player in
                // Re-authenticating a Minecraft account when it's already linked is not currently
                // supported, as this may cause some unexpected results
                guard player.accountId == nil else {
                    throw CustomHttpError(status: .forbidden, reason: "This UUID has already been authenticated", identifier: "account_already_linked")
                }

                let oneHour: Double = 60 * 60
                let authCode = MinecraftAuthCode(
                    uuid: uuid,
                    token: UUID().uuidString,
                    minecraftPlayerId: try player.requireID(),
                    expiresAt: Date().addingTimeInterval(oneHour)
                )
                return authCode.create(on: request)
            }
            .map { minecraftAuthCode in
                minecraftAuthCode.toResource()
            }
    }
}
