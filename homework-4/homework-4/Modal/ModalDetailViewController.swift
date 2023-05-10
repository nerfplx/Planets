import UIKit
import SnapKit

class ModalDetailViewController: UIViewController {
    
    private let closeButton = UIButton()
    private let buttonText = "Close"
    
    private enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
    }
    private let constraitTopButton = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    @objc func tapButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

private extension ModalDetailViewController {
    func setupUI() {
        self.configureData()
        self.configureLayout()
        self.configureBackground()
    }
    
    func configureBackground() {
        self.view.backgroundColor = .white
    }
    
    func configureData() {
        self.closeButton.setTitle(buttonText, for: .normal)
        self.closeButton.setTitleColor(.white, for: .normal)
        self.closeButton.backgroundColor = .black
        self.closeButton.layer.cornerRadius = Constants.cornerRadius
        self.closeButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func configureLayout() {
        self.view.addSubview(self.closeButton)
        self.closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(constraitTopButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}
