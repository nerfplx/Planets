import UIKit
import SnapKit

protocol DetailViewProtocol: AnyObject {
    func displayItemDetails(_ item: Item)
}

class DetailView: UIView {
    private(set) var nameLabel = UILabel()
    private(set) var imageView = UIImageView()
    private(set) var button = UIButton()
    private let buttonLabel = "Detail"
}

extension DetailView {
    func setupUI() {
        configureData()
        configureLayout()
    }
    
    private enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
    }
    
    private enum Constraints {
        static let horizontalImage = 30
        static let topButton = 30
        static let bottomImage = -100
    }
    
    private func configureData() {
        backgroundColor = .black
        
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 21)
        nameLabel.textColor = .white
        nameLabel.adjustsFontSizeToFitWidth = true
        
        button.setTitle(buttonLabel, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = Constants.cornerRadius
    }
    
    private func configureLayout() {
        
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(Constraints.horizontalImage)
        }
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(Constraints.bottomImage)
        }
        
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(Constraints.topButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}

