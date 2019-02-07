import UIKit

protocol AppRouterType {
    var navigationController: UINavigationController { get set }
    func start()
}
