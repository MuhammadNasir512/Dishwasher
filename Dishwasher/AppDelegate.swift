import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainRouter: MainRouter?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupGridFeature()
        return true
    }
}

private extension AppDelegate {
    
    private func setupGridFeature() {
        let navigationController = UINavigationController()
        mainRouter = MainRouter(navigationController: navigationController)
        mainRouter?.start()
        window?.rootViewController = navigationController
    }
}
