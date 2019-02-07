import UIKit

final class Attribute: Codable {
    let attributeId: String
    let name: String
    let value: String
    
    init(json: [String: AnyObject]) {
        attributeId = json[CodingKeys.attributeId.rawValue] as? String ?? ""
        name = json[CodingKeys.name.rawValue] as? String ?? ""
        value = json[CodingKeys.value.rawValue] as? String ?? ""
    }
}

private extension Attribute {
    enum CodingKeys: String, CodingKey {
        case attributeId = "id"
        case name = "name"
        case value = "value"
    }
}

extension Attribute {
    static func attributesFrom(jsonArray: [[String: AnyObject]]) -> [Attribute] {
        var attributes = [Attribute]()
        for attributesJson in jsonArray {
            attributes.append(Attribute(json: attributesJson))
        }
        return attributes
    }
}
