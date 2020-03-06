//
//  ModelResource.swift
//  App
//
//  Created by Andy Saw on 2020/03/06.
//

import Vapor
import Fluent

protocol ModelResource: Content {

    associatedtype RawModel: Model
    init(rawModel model: RawModel)
}

protocol ModelResourceConvertible: Model {

    associatedtype Resource: ModelResource
    func toResource() -> Resource
}

extension ModelResourceConvertible where Resource.RawModel == Self {

    func toResource() -> Resource {
        return Resource.init(rawModel: self)
    }
}
