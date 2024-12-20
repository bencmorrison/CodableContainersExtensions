// Copyright © 2024 Ben Morrison. All rights reserved.

import Foundation

extension SingleValueEncodingContainer {
    /// Encodes a single value of the given converted type
    /// - Parameter converter: The converter that will convert the type to the final type.
    /// - Throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - Precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    mutating func encode<T: Encodable>(_ converter: () throws -> T) throws {
        let converted = try converter()
        try encode(converted)
    }
}
