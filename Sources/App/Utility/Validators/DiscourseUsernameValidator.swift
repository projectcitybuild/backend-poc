//
//  DiscourseUsernameValidator.swift
//  App
//
//  Created by Andy Saw on 2020/03/07.
//

import Vapor

extension Validator where T == String {

    /// Validates that the data doesn't exist in the given field of any of the given model type
    ///
    ///     try validations.add(\.username, .unique(in: Account.self, field: \.username))
    ///
    public static var allowedDiscourseUsername: Validator<T> {
        return DiscourseUsernameValidator().validator()
    }
}

/// Swift implementation of
/// https://github.com/discourse/discourse/blob/888e68a1637ca784a7bf51a6bbb524dcf7413b13/app/models/username_validator.rb
//
fileprivate struct DiscourseUsernameValidator: ValidatorType {

    // Usernames must consist of a-z A-Z 0-9 _ - .
    private let ASCII_INVALID_CHARACTERS = #"/[^\w.-]/"#

    // Usernames can start with a-z A-Z 0-0 _
    private let VALID_LEADING_CHARACTERS = #"/^[a-zA-Z0-9_]/"#

    // Usernames must end with a-z A-Z 0-9
    private let VALID_TRAILING_CHARACTERS = #"/[a-zA-Z0-9]$/"#

    // Underscores, dashes and dots can't be repeated consecutively
    private let REPEATING_CONFUSING_CHARACTERS = #"/[-_.]{2,}/"#

    private let CONFUSING_EXTENSIONS = #"/\.(js|json|css|htm|html|xml|jpg|jpeg|png|gif|bmp|ico|tif|tiff|woff)$/i"#


    var validatorReadable: String {
        return "discourse_username"
    }

    func validate(_ data: String) throws {
        guard data.count > 3 else {
            throw BasicValidationError("must be greater than 3 characters")
        }
        guard data.count <= 20 else {
            throw BasicValidationError("must be less than 21 characters")
        }
        guard data.range(of: ASCII_INVALID_CHARACTERS, options: .regularExpression) == nil else {
            throw BasicValidationError("must only include numbers, letters, dashes, and underscores")
        }
        guard data.range(of: VALID_LEADING_CHARACTERS, options: .regularExpression) == nil else {
            throw BasicValidationError("must begin with a letter, a number or an underscore")
        }
        guard data.range(of: VALID_TRAILING_CHARACTERS, options: .regularExpression) == nil else {
            throw BasicValidationError("must end with a letter or a number")
        }
        guard data.range(of: REPEATING_CONFUSING_CHARACTERS, options: .regularExpression) == nil else {
            throw BasicValidationError("must not contain a sequence of 2 or more special chars (.-_)")
        }
        guard data.range(of: CONFUSING_EXTENSIONS, options: .regularExpression) == nil else {
            throw BasicValidationError("must not end with a confusing suffix like .json or .png etc.")
        }
    }
}
