# CodableContainersExtensions

Codable Conainers Extensions is a small set of extensions on the following types:

- `KeyedDecodingContainerProtocol`
- `KeyedEncodingContainerProtocol`
- `SingleValueDecodingContainer`
- `SingleValueEncodingContainer`
- `UnkeyedDecodingContainer`
- `UnkeyedEncodingContainer`

## What it adds

It the abilty to convert a value at time of decoding or encoding. So if you have a value coming from an API that isn't what you need, you can use the convert closure to fix it. You can do this for encoding as well.

### Example

This is a super basic example to show the usage.

```swift
struct BasicExample: Codable {
    /// Name of the item
    let name: String
    /// URL of the item
    let url: URL
    /// Details of the item
    /// API Issues an empty string instead of null when empty
    let details: String?

    enum CodingKeys: String, CodingKey {
        case name, url, details
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(URL.self, forKey: .url)
        // Since we will always have a value we will use the convert.
        details = try container.decode(String.self, forKey: .details) {
            $0.isEmpty ? nil : $0
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
        // Always return a value if details is nil
        try container.encode({ details ?? "" }, forKey: .details)
    }
}
```
