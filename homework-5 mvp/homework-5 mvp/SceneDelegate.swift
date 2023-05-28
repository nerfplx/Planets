import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let navigationBarItem = "Favourite hookah flavors"
        let model = ItemsModel()
        let mainPresenter = MainPresenter(model: model)
        let mainViewController = MainViewController(presenter: mainPresenter)
        mainPresenter.view = mainViewController
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = navigationController
        navigationController.navigationBar.topItem?.title = navigationBarItem
        navigationController.navigationBar.tintColor = .white
        self.window?.makeKeyAndVisible()
    }
}

