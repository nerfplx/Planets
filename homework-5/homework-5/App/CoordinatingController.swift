import UIKit



protocol INavigationItem: AnyObject {
    var vc: UIViewController { get }
}

enum NavigationModule {
    case mainVC
    case detailVC
}

protocol ICoordinatingController: AnyObject {
    
    func back(animated: Bool)
    func push(module: NavigationModule, animated: Bool)
}

final class CoordinatingController {
    
    private var modules = [NavigationModule: INavigationItem]()
    private var modulesStack = [INavigationItem]()
    
    func register(module: NavigationModule, navItem: INavigationItem) {
        self.modules[module] = navItem
        self.modulesStack.append(navItem)
    }
}

extension CoordinatingController: ICoordinatingController {
    
    func push(module: NavigationModule, animated: Bool) {
        guard let nextModule = self.modules[module] else {
            assertionFailure("Модуль не зарегистрирован")
            return
        }

        if self.modulesStack.last?.vc == nextModule.vc {
            self.modulesStack.removeLast()
        }
        
        let navigationController = self.modulesStack.last?.vc.navigationController
        navigationController?.pushViewController(nextModule.vc, animated: animated)
        self.modulesStack.append(nextModule)
    }
    
    func back(animated: Bool) {
        let last = self.modulesStack.popLast()
        
        guard let navigationController = last?.vc.navigationController else {
            last?.vc.dismiss(animated: animated)
            return
        }
        navigationController.popViewController(animated: animated)
    }
}

