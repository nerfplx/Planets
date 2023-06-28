import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    func navigateToDetailViewController(_ detailViewController: UIViewController)
}

final class MainViewController: UIViewController, MainViewProtocol {
    private let presenter: MainPresenterProtocol
    private let customView: MainView
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        self.customView = MainView(presenter: presenter)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.customView
        presenter.viewDidLoad()
    }
}

extension MainViewController {
    func navigateToDetailViewController(_ detailViewController: UIViewController) {
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
