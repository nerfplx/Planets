import UIKit
import SnapKit

final class ProfileView: UIView {
    
    private(set) var nameLabel = UILabel()
    private(set) var phoneLabel = UILabel()
    private(set) var titleLabel = UILabel()
    private(set) var logoutButton = UIButton()
    private(set) var activityIndicator = UIActivityIndicatorView()
    private(set) var favouritePlanetLabel = UILabel()
    private(set) var backgroundImageView = UIImageView()
    
    private enum Constants {
        static let titleSystemFontSize = CGFloat(20)
        static let phoneLabelSystemFontSize = CGFloat(18)
        static let logoutButtonWidth = CGFloat(200)
        static let logoutButtonHeight = CGFloat(50)
        static let logoutButtonCornerRadius = CGFloat(10)
    }
    
    private enum Constraits {
        static let leadingEqualToSuperview = CGFloat(60)
        static let topEqualToSupreview = CGFloat(20)
        static let bottonEqualToSuperview = CGFloat(-50)
        static let topEqualToNameLabel = CGFloat(10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    
    func setupUI() {
        configureBackgroundImageView()
        configureTitleLabel()
        configureNameLabel()
        configurePhoneLabel()
        configureLogoutButton()
        configureActivityIndicator()
        configureFavouritePlanetLabel()
    }
    
    func configureBackgroundImageView() {
        addSubview(backgroundImageView)
        self.backgroundImageView.image = UIImage(named: "authBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurredEffectView)
        blurredEffectView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundImageView)
        }
    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "Profile"
        titleLabel.textColor = .orange
        titleLabel.font = .systemFont(ofSize: Constants.titleSystemFontSize, weight: .bold)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
        }
    }
    
    func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.textColor = .orange
        nameLabel.font = .systemFont(ofSize: Constants.titleSystemFontSize)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constraits.topEqualToSupreview)
        }
    }
    
    func configurePhoneLabel() {
        addSubview(phoneLabel)
        phoneLabel.textColor = .orange
        phoneLabel.font = .systemFont(ofSize: Constants.phoneLabelSystemFontSize)
        phoneLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
            make.top.equalTo(nameLabel.snp.bottom).offset(Constraits.topEqualToNameLabel)
        }
    }
    
    func configureLogoutButton() {
        addSubview(logoutButton)
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.backgroundColor = .orange
        logoutButton.layer.cornerRadius = Constants.logoutButtonCornerRadius
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(Constraits.bottonEqualToSuperview)
            make.width.equalTo(Constants.logoutButtonWidth)
            make.height.equalTo(Constants.logoutButtonHeight)
        }
    }
    
    func configureActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.color = .orange
        activityIndicator.style = .large
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureFavouritePlanetLabel() {
        addSubview(favouritePlanetLabel)
        favouritePlanetLabel.textColor = .orange
        favouritePlanetLabel.font = .systemFont(ofSize: Constants.phoneLabelSystemFontSize)
        favouritePlanetLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
            make.top.equalTo(phoneLabel.snp.bottom).offset(Constraits.topEqualToSupreview)
        }
    }
}


