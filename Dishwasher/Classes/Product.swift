import UIKit

final class Product: Codable {

    let productId: String
    let title: String
    let image: String
    let price: String

    init(json: [String: AnyObject]) {
        productId = json[CodingKeys.productId.rawValue] as? String ?? ""
        title = json[CodingKeys.title.rawValue] as? String ?? ""
        image = json[CodingKeys.image.rawValue] as? String ?? ""
        let priceObject = Price(json: (json[CodingKeys.price.rawValue] as? [String: AnyObject] ?? [:]))
        price = priceObject?.now ?? ""
    }
}

private extension Product {
    enum CodingKeys: String, CodingKey {
        case productId = "productId"
        case title = "title"
        case image = "image"
        case price = "price"
    }
}

extension Product {
    static func productsFrom(jsonArray: [[String: AnyObject]]) -> [Product] {
        var products = [Product]()
        for productsJson in jsonArray {
            products.append(Product(json: productsJson))
        }
        return products
    }
}

final class Price: Codable {
    let now: String
    init?(json: [String: AnyObject]) {
        now = json["now"] as? String ?? ""
    }
}
