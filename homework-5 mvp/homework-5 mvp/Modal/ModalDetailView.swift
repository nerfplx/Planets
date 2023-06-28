import SnapKit
import UIKit

class ModalDetailView: UIView {
    private(set) var closeButton = UIButton()
    private let buttonLabel = "Close"
    
    func setupUI() {
        configureData()
        configureLayout()
        configureBackground()
    }
}

private extension ModalDetailView {
    
    enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
        static let constraitTopButton = 50
    }
    
    func configureBackground() {
        backgroundColor = .white
    }
    
    func configureData() {
        closeButton.setTitle(buttonLabel, for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .black
        closeButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    func configureLayout() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.constraitTopButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}
