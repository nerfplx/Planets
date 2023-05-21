import UIKit
import SnapKit

class ModalDetailViewController: UIViewController, ModalDetailViewProtocol {
    
    private let closeButton = UIButton()
    private let presenter = ModalDetailPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        setupUI()
        presenter.viewDidLoad()
    }
    
    @objc func tapButton(_ sender: Any) {
        presenter.closeButtonTapped()
    }
}

private extension ModalDetailViewController {
    
    private enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
        static let constraitTopButton = 50
    }
    
    func setupUI() {
        configureData()
        configureLayout()
        configureBackground()
    }
    
    func configureBackground() {
        view.backgroundColor = .white
    }
    
    func configureData() {
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .black
        closeButton.layer.cornerRadius = Constants.cornerRadius
        closeButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func configureLayout() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.constraitTopButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}

extension ModalDetailViewController {
    func setTitle(_ title: String) {
        closeButton.setTitle(title, for: .normal)
    }
    func dismissView() {
        dismiss(animated: true)
    }
}
