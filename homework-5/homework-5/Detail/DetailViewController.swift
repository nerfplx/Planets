import UIKit

class DetailViewController: UIViewController {
    
    private let customView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.customView
        self.setupUI()
    }
    
    @objc func tapButton(_sender: Any) {
        let vc = ModalDetailViewController(nibName: nil, bundle: nil)
        self.present(vc, animated: true)
    }
}

private extension DetailViewController {
    func setupUI() {
        customView.button.addTarget(self, action: #selector(DetailViewController.tapButton), for: .touchUpInside)
    }
}
 
extension DetailViewController: INavigationItem {
    var vc: UIViewController { self }
}

