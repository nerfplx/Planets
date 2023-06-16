import UIKit
import SnapKit

final class PlanetCell: UITableViewCell {
    static let identifier = "PlanetCell"
    
    private let planetLabel = UILabel()
    private let favouriteImageView = UIImageView()
    
    private enum Constraits {
        static let leadingEqualToSuperviewPlanetLabel = CGFloat(40)
        static let centerYequalToSuperviewFavouriteImage = CGFloat(-2)
        static let leadingEqualToSuperviewFavouriteImage = CGFloat(10)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with planet: Planet) {
        planetLabel.text = planet.title
        planetLabel.textColor = .orange
        planetLabel.font = UIFont(name: "Overpass-Regular", size: 19)
        favouriteImageView.image = planet.isFavourite ? UIImage(systemName: "heart.fill") : nil
    }
}

private extension PlanetCell {
    
    func setupUI() {
        self.backgroundColor = .clear
        configurePlanetLabel()
        configureFavouriteImageView()
    }
    
    func configurePlanetLabel() {
        addSubview(planetLabel)
        planetLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperviewPlanetLabel)
        }
    }
    
    func configureFavouriteImageView() {
        addSubview(favouriteImageView)
        favouriteImageView.tintColor = .orange
        favouriteImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constraits.centerYequalToSuperviewFavouriteImage)
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperviewFavouriteImage)
        }
    }
}
