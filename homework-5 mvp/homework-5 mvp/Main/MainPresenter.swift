import UIKit

protocol MainPresenterProtocol: AnyObject {
    var items: [Item] { get }
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    private let model: ItemsModelProtocol
    private(set) var items: [Item] = []
    
    init(model: ItemsModelProtocol) {
        self.model = model
    }
    
    func viewDidLoad() {
        model.fetchItems { [weak self] items in
            self?.items = items
        }
    }
}

extension MainPresenter {
    
    func didSelectItem(at indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
            let detailPresenter = DetailPresenter(item: selectedItem)
            let detailViewController = DetailViewController(presenter: detailPresenter)
            detailPresenter.view = detailViewController

        view?.navigateToDetailViewController(detailViewController)
    }
}
