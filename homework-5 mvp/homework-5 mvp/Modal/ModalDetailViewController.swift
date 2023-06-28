import UIKit
import SnapKit

final class ModalDetailViewController: UIViewController, ModalDetailViewProtocol {
    
    private var presenter = ModalDetailPresenter()
    private let customView = ModalDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = customView
        customView.setupUI()
        presenter.view = self
        customView.closeButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
}

extension ModalDetailViewController {
    @objc func tapButton(_ sender: Any) {
        presenter.closeButtonTapped()
    }
    
    func dismissView() {
        dismiss(animated: true)
    }
}
