//
//  MojangPlayerClient.swift
//  App
//
//  Created by Andy Saw on 2020/03/07.
//

import Vapor

final class MojangPlayerClient {

    struct MojangPlayer {

    }

    func fetchPlayer(request: Request, username: String, at timestamp: TimeInterval? = nil) -> EventLoopFuture<MojangPlayer> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mojang.com"
        urlComponents.path = "/users/profiles/minecraft/" + username

        if let timestamp = timestamp {
            urlComponents.queryItems = [URLQueryItem(name: "at", value: String(timestamp))]
        }

        guard let endpointUrl = urlComponents.url else {
            // TODO
            fatalError()
        }

        do {
            return try request.client().get(endpointUrl).map { response in
                // TODO
                fatalError()
            }
        } catch {
            print(error)
            fatalError()
        }
    }
}
