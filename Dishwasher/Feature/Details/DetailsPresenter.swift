import Foundation

protocol DetailsPresenterType {
    func startLoadingData()
}

final class DetailsPresenter: DetailsPresenterType {
    
    let interactor: DetailsInteractorType
    let jsonUtility: JsonUtilityType
    let router: MainRouterType
    let itemSelected: ItemCellModel
    var viewController: DetailsViewControllerType?
    
    init(
        interactor: DetailsInteractorType,
        router: MainRouterType,
        itemSelected: ItemCellModel,
        jsonUtility: JsonUtilityType = JsonUtility()
        ) {
        self.interactor = interactor
        self.itemSelected = itemSelected
        self.jsonUtility = jsonUtility
        self.router = router
    }
    
    func startLoadingData() {
        interactor.loadDetailsData()
    }
}

extension DetailsPresenter: DetailsInteractorDelegate {
    
    func didLoadDetails(jsonResponse: [String : AnyObject]) {
        let attributes = jsonUtility.extractAttributes(json: jsonResponse) ?? []
        var itemModels = SubtitleCellModel.subtitleCellModelsFrom(items: attributes)
        let productSpecs = RootCellModel(title: "Product Specifications")
        itemModels.insert(productSpecs, at: 0)
        viewController?.screenTitle = itemSelected.title
        viewController?.didLoadDetailsData(items: itemModels)
    }
}
