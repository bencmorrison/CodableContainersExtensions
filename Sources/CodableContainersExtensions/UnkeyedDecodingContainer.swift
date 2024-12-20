// Copyright © 2024 Ben Morrison. All rights reserved.

import Foundation

extension UnkeyedDecodingContainer {
    /// Decodes a value of the given type and then converts to to the final type.
    ///
    /// This can be useful if you are decoding from an API object that returns a type
    /// that doesn't make sense in code such as a float as a string. This allows you to
    /// decode the string then convert the string to the float in one line.
    ///
    /// - Parameters:
    ///   - type: The type of value to decode.
    ///   - convert: The closure used to convert the type to the expected type.
    /// - Returns: A value of the converted type if present for the given key.
    /// - Throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - Throws: `DecodingError.valueNotFound` if the encountered encoded value
    ///   is null, or of there are no more values to decode.
    mutating func decode<T: Decodable, C>(_ type: T.Type, convert: (T) throws -> C) throws -> C {
        let value = try decode(T.self)
        return try convert(value)
    }
    
    /// Decodes a value of the given type, if present.
    ///
    /// This method returns `nil` if the container has no elements left to
    /// decode, or if the value is null. The difference between these states can
    /// be distinguished by checking `isAtEnd`.
    ///
    /// Convert is only called when the value of the type defined is present.
    ///
    /// - Parameters:
    ///   - type: The type of value to decode.
    ///   - convert: The conversion closure to convert from the given type to the expected.
    /// - Returns: A converted value of the requested type, or `nil` if the value
    ///   is a null value, or if there are no more elements to decode.
    /// - Throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    mutating func decodeIfPresent<T: Decodable, C>(_ type: T.Type, convert: (T) throws -> C) throws -> C? {
        guard let value = try decodeIfPresent(T.self) else { return nil }
        return try convert(value)
    }
}
