import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let coordinatingController = CoordinatingController()
    private lazy var flowController = FlowController(coordinatingController: self.coordinatingController)
    lazy var navigationController: UINavigationController = {
        UINavigationController(rootViewController: self.flowController.mainVC.vc)
    }()
    private let navigationBarItem = "Favourite hookah flavors"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = self.navigationController
        self.navigationController.navigationBar.topItem?.title = navigationBarItem
        self.navigationController.navigationBar.tintColor = .white
        self.window?.makeKeyAndVisible()
    }
}

