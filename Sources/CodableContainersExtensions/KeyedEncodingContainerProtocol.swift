// Copyright © 2024 Ben Morrison. All rights reserved.

import Foundation

extension KeyedEncodingContainerProtocol {
    /// Encodes the given output of the converted value for the given key.
    ///
    /// Created to make converting to different types a bit more noticeable when required.
    ///
    /// - Parameters:
    ///   - converter: The closure that will return the value to encode
    ///   - key: The key to associate the value with.
    /// - Throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public mutating func encode<T: Encodable>(_ converter: () throws -> T, forKey key: Self.Key) throws {
        let result = try converter()
        try encode(result, forKey: key)
    }
    
    /// Encodes the given value for the given key if the converter doesn't return `nil`.
    ///
    /// - Parameters:
    ///   - converter: The value to encode.
    ///   - key: The key to associate the value with.
    /// - Throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public mutating func encodeIfConverted<T: Encodable>(_ converter: () throws -> T?, forKey key: Self.Key) throws {
        let result = try converter()
        try encodeIfPresent(result, forKey: key)
    }
}
