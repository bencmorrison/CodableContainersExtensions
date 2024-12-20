// Copyright © 2024 Ben Morrison. All rights reserved.

import Foundation

extension SingleValueDecodingContainer {
    /// Decodes a single value of the given type and converts it to the expected value.
    /// - Parameters:
    ///   - type: The type to decode as.
    ///   - convert: The converting closure that takes in the given type and converts it
    ///   to the expected type.
    /// - Returns: A converted value of the requested type.
    /// - Throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   cannot be converted to the requested type.
    /// - Throws: `DecodingError.valueNotFound` if the encountered encoded value
    ///   is null.
    func decode<T: Decodable, C>(_ type: T.Type, convert: (T) throws -> C) throws -> C {
        let value = try decode(T.self)
        return try convert(value)
    }
}
