// Copyright © 2024 Ben Morrison. All rights reserved.

import Foundation

extension KeyedDecodingContainerProtocol {
    /// Decodes a value of the given type for the given key and then passes the
    /// value to a converter closure that allows further manipulation of the value.
    ///
    /// This can be useful if you are decoding from an API object that returns a type
    /// that doesn't make sense in code such as a float as a string. This allows you to
    /// decode the string then convert the string to the float in one line.
    ///
    /// - Parameters:
    ///   - type: The type of value to decode.
    ///   - key: The key that the decoded value is associated with.
    ///   - convert: The closure that will be called to do the conversion of the value.
    /// - Returns: The value of the requested type that has been run through the conversion closure
    /// - Throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - Throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - Throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode<T: Decodable, C>(
        _ type: T.Type, forKey key: Self.Key, convert: (T) throws -> C
    ) throws -> C {
        let decoded = try self.decode(type, forKey: key)
        return try convert(decoded)
    }

    /// Decodes a value of the given type for the given key, if present, and when
    /// present passes it to the converter closure to be converted.
    ///
    /// This method returns `nil` if the container does not have a value
    /// associated with `key`, if the value is null, or the convert returns nil.
    /// The difference between these states can be distinguished with a `contains(_:)` call.
    ///
    /// This can be useful if you are decoding from an API object that returns a type
    /// that doesn't make sense in code such as a float as a string. This allows you to
    /// decode the string then convert the string to the float in one line.
    ///
    /// - Parameters:
    ///   - type: The type of value to decode.
    ///   - key: The key that the decoded value is associated with.
    ///   - convert: The closure that will be called to do the conversion of the value.
    /// - Returns: The value of the requested type that has been run through the conversion closure.
    ///   IF the `Decoder` does not have an entry associated with the key, value is null, or
    ///   the convert closure returns nil, the value will be `nil`.
    /// - Throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    public func decodeIfPresent<T: Decodable, C>(
        _ type: T.Type, forKey key: Self.Key, convert: (T) throws -> C
    ) throws -> C? {
        guard let value = try decodeIfPresent(type, forKey: key) else { return nil }
        return try convert(value)
    }
}
