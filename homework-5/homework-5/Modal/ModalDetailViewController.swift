import UIKit

class ModalDetailViewController: UIViewController {
    
    private var customView = ModalDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.customView
        self.setupUI()
    }
    
    @objc func tapButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

private extension ModalDetailViewController {
    func setupUI() {
        customView.closeButton.addTarget(self, action: #selector(ModalDetailViewController().tapButton), for: .touchUpInside)
    }
}

