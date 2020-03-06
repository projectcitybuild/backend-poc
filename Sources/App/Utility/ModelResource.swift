//
//  ModelResource.swift
//  App
//
//  Created by Andy Saw on 2020/03/06.
//

import Vapor
import Fluent

/// Represents a public-facing model that our internal models can map into when displayed
/// in a response. By mapping our models into resources, our internal models can change
/// without causing breaking changes for users of our public API
protocol ModelResource: Content {

    associatedtype RawModel: Model
    init(rawModel model: RawModel)
}

/// Provides a convenience method to automatically map the current model into its corresponding,
/// public-facing resource model
protocol ModelResourceConvertible: Model {

    associatedtype Resource: ModelResource
    func toResource() -> Resource
}

extension ModelResourceConvertible where Resource.RawModel == Self {

    func toResource() -> Resource {
        return Resource.init(rawModel: self)
    }
}
