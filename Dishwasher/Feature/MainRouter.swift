import UIKit

protocol MainRouterType: AppRouterType {
    func didSelectGridItem(item: ItemCellModel)
}

final class MainRouter: MainRouterType {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "GridViewController") as? GridViewController {
            let urlString = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20"
            let apiHandler = APIHandler(urlString: urlString)
            let dataSource = GridDataSource()
            let interactor = GridInteractor(apiHandler: apiHandler)
            let presenter = GridPresenter(interactor: interactor, router: self)
            viewController.presenter = presenter
            viewController.dataSource = dataSource
            dataSource.viewController = viewController
            presenter.viewController = viewController
            interactor.delegate = presenter
            navigationController.pushViewController(viewController, animated: false)
        }
    }
    
    func didSelectGridItem(item: ItemCellModel) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            let urlString = "https://api.johnlewis.com/v1/products/\(item.id)?key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
            let apiHandler = APIHandler(urlString: urlString)
            let dataSource = DetailsDataSource()
            let interactor = DetailsInteractor(apiHandler: apiHandler)
            let presenter = DetailsPresenter(interactor: interactor, router: self, itemSelected: item)
            viewController.presenter = presenter
            viewController.dataSource = dataSource
            dataSource.viewController = viewController
            presenter.viewController = viewController
            interactor.delegate = presenter
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
