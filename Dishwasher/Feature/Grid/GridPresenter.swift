import Foundation

protocol GridPresenterType {
    func startLoadingData()
    func didSelectItem(item: ItemCellModel)
}

final class GridPresenter: GridPresenterType {
    
    let interactor: GridInteractorType
    let jsonUtility: JsonUtilityType
    let router: MainRouterType
    var viewController: GridViewControllerType?

    init(interactor: GridInteractorType, router: MainRouterType, jsonUtility: JsonUtilityType = JsonUtility()) {
        self.interactor = interactor
        self.jsonUtility = jsonUtility
        self.router = router
    }

    func startLoadingData() {
        interactor.loadGridData()
    }
    
    func didSelectItem(item: ItemCellModel) {
        router.didSelectGridItem(item: item)
    }
}

extension GridPresenter: GridInteractorDelegate {
    
    func didLoadGrid(jsonResponse: [String : AnyObject]) {
        let products = jsonUtility.extractProducts(json: jsonResponse) ?? []
        let itemModels = ItemCellModel.itemModelsFrom(products: products)
        viewController?.didLoadGridData(items: itemModels)
    }
}
