



final class FlowController {
    
    let mainVC: INavigationItem

    private let coordinatingController: CoordinatingController
    private var modules = [INavigationItem]()
    
    init(coordinatingController: CoordinatingController) {
        self.coordinatingController = coordinatingController
        
        self.mainVC = CollectionViewController(coordinatingController: coordinatingController)
        
        self.coordinatingController.register(module: .mainVC, navItem: self.mainVC)
        self.modules.append(self.makeDetailViewController())
    }
}

private extension FlowController {
    
    func makeDetailViewController() -> INavigationItem {
        let vc = DetailViewController()
        self.coordinatingController.register(module: .detailVC, navItem: vc)
        return vc
    }
}
