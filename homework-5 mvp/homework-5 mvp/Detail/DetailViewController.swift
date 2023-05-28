import UIKit

final class DetailViewController: UIViewController, DetailViewProtocol {
    private let presenter: DetailPresenterProtocol?
    private let customView = DetailView()
    
    init(presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = customView
        customView.setupUI()
        customView.button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        presenter?.viewDidLoad()
    }
}

extension DetailViewController {
    @objc func tapButton(_ sender: Any) {
        let vc = ModalDetailViewController(nibName: nil, bundle: nil)
        self.present(vc, animated: true)
    }
    
    func displayItemDetails(_ item: Item) {
        customView.nameLabel.text = item.name
        customView.imageView.image = item.image
    }
}
