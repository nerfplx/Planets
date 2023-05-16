import SnapKit
import UIKit


class DetailView: UIView {
    
    private let buttonText = "Detail"
    var cell: CollectionCellModel?

    private var nameLabel = UILabel()
    private var imageView = UIImageView()
    var button = UIButton()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailView {
    
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
    
    func setupUI() {
        self.configureData()
        self.configureLayout()
        self.setupCell(CollectionCellModel())
    }
    
    func setupCell(_ viewModel: CollectionCellModel) {
        self.nameLabel.text = cell?.name
        if let image = cell?.image {
            self.imageView.image = image
        }
    }
    
    func configureData() {
        self.backgroundColor = .black
                
        self.imageView.contentMode = .scaleAspectFit
        
        self.nameLabel.textAlignment = .left
        self.nameLabel.font = .boldSystemFont(ofSize: 21)
        self.nameLabel.textColor = .white
        self.nameLabel.adjustsFontSizeToFitWidth = true
        
        self.button.setTitle(buttonText, for: .normal)
        self.button.setTitleColor(.white, for: .normal)
        self.button.backgroundColor = .darkGray
        self.button.layer.cornerRadius = Constants.cornerRadius
    }
    
    func configureLayout() {
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
        
        self.addSubview(self.button)
        self.button.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(Constraints.topButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}
