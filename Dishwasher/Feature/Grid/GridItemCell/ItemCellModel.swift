import UIKit

final class ItemCellModel {
    
    var id = "Id"
    var title = "Title"
    var subtitle = "SubTitle"
    var imageUrl: String
    var image: UIImage?

    init(product: Product) {
        id = product.productId
        title = product.title
        subtitle = product.price
        imageUrl = "https:\(product.image)"
    }
}

extension ItemCellModel {
    static func itemModelsFrom(products: [Product]) -> [ItemCellModel] {
        var itemModels = [ItemCellModel]()
        for product in products {
            itemModels.append(ItemCellModel(product: product))
        }
        return itemModels
    }
}
