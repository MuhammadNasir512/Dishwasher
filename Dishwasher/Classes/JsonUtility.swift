import Foundation

protocol JsonUtilityType {
    func extractProducts(json: [String: AnyObject]) -> [Product]?
    func extractAttributes(json: [String: AnyObject]) -> [Attribute]?
}

final class JsonUtility: JsonUtilityType {
    
    func extractProducts(json: [String : AnyObject]) -> [Product]? {
        guard let productsJson = json["products"] as? [[String: AnyObject]] else { return nil }
        return Product.productsFrom(jsonArray: productsJson)
    }
    
    func extractAttributes(json: [String: AnyObject]) -> [Attribute]? {
        guard
            let details = json["details"] as? [String: AnyObject],
            let features = details["features"] as? [[String: AnyObject]],
            let oneFeatue = features.first,
            let attributes = oneFeatue["attributes"] as? [[String: AnyObject]]
            else { return nil }
        return Attribute.attributesFrom(jsonArray: attributes)
    }
}
