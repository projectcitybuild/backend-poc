//
//  CustomHttpError.swift
//  App
//
//  Created by Andy Saw on 2020/03/06.
//

import Vapor

/// A generic HTTP error. If possible, a more context-specific error
/// should be used instead of this
struct CustomHttpError: AbortError {
    var status: HTTPResponseStatus
    var reason: String
    var identifier: String
}
