//
//  EventLoopFuture+Extensions.swift
//  App
//
//  Created by Andy Saw on 2020/03/06.
//

import Vapor

extension EventLoopFuture {

    /// Performs a map (to return a non-nil value of the same type) only if the current value is nil
    ///
    /// - Parameter callback: mapping function
    func mapIfNil<Wrapped>(_ callback: @escaping () -> Wrapped) -> EventLoopFuture<Wrapped> where T == Optional<Wrapped> {
        return map { optionalResult in optionalResult ?? callback() }
    }

    /// Performs a flatMap (to return a non-nil future value of the same type) only if the current value is nil
    ///
    /// - Parameter callback: flatMap function
    func flatMapIfNil<Wrapped>(_ callback: @escaping () -> EventLoopFuture<Wrapped>) -> EventLoopFuture<Wrapped> where T == Optional<Wrapped> {
        return flatMap { optionalResult in
            if let result = optionalResult {
                return self.eventLoop.newSucceededFuture(result: result)
            }
            return callback()
        }
    }
}
