import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    private let item: Item
    
    init(item: Item) {
        self.item = item
    }
}

extension DetailPresenter {
    func viewDidLoad() {
        view?.displayItemDetails(item)
    }
}
