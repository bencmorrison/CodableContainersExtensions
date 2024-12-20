// Copyright © 2024 Ben Morrison. All rights reserved.

import Foundation

extension UnkeyedEncodingContainer {
    /// Encodes the given value from the converter
    /// - Parameter converter: The closure that converts the value to the expected
    ///   type for encoding
    /// - Throws:`EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    mutating func encode<T: Encodable>(_ converter: () throws -> T) throws {
        let result = try converter()
        try encode(result)
    }
}
