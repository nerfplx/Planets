import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let cellView = UIView()
    
    static let identifier = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(cellView)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        self.configureData()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: Item) {
        imageView.image = item.image
        nameLabel.text = item.name
    }
}

private extension CollectionViewCell {
    
    private func configureData() {
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        
        self.nameLabel.textAlignment = .center
        self.nameLabel.font = .italicSystemFont(ofSize: 12)
        self.nameLabel.textColor = .black
        self.nameLabel.backgroundColor = .clear
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.minimumScaleFactor = 0.5
    }
    
    func configureLayout() {
        self.addSubview(self.cellView)
        self.cellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.cellView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.cellView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
