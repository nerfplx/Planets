import UIKit
import SnapKit


class ModalDetailView: UIView {
    
    let closeButton = UIButton()
    private let buttonText = "Close"
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ModalDetailView {
    
    private enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
    }
    private enum Constraints {
        static let constraitTopButton = 50
    }
    
    func setupUI() {
        self.configureData()
        self.configureLayout()
        self.configureBackground()
    }
    
    func configureBackground() {
        self.backgroundColor = .white
    }
    
    func configureData() {
        self.closeButton.setTitle(buttonText, for: .normal)
        self.closeButton.setTitleColor(.white, for: .normal)
        self.closeButton.backgroundColor = .black
        self.closeButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    func configureLayout() {
        self.addSubview(self.closeButton)
        self.closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.constraitTopButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}
