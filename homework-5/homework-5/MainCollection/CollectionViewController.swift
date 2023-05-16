import UIKit

class CollectionViewController: UIViewController {
    
    private let customView = CollectionView()
    private let coordinatingController: CoordinatingController
    
    init(coordinatingController: CoordinatingController) {
        self.coordinatingController = coordinatingController
        super.init(nibName: nil, bundle: nil)
        self.customView.completionHandler = { [weak self] item in
            DetailView().cell = item
            self?.coordinatingController.push(module: .detailVC, animated: true)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.customView
    }
}

extension CollectionViewController: INavigationItem {
    var vc: UIViewController { self }
}

