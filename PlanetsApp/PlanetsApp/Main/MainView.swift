import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    var planetTableViewHandler: PlanetTableView? { get set }
    func reloadData()
}

final class MainView: UIView, MainViewProtocol, PlanetTableViewHandlerDelegate {
    
    private let presenter = MainViewPresenter()
    private let titleLabel = UILabel()
    private let loginButton = UIButton()
    private let backgroundImageView = UIImageView()
    
    private(set) var tableView = UITableView()
    
    var showAuthView: (() -> Void)?
    var showProfileView: (() -> Void)?
    var didSelectPlanet: ((Planet) -> Void)?
    var planetTableViewHandler: PlanetTableView? = PlanetTableView()
    
    private enum Constraits {
        static let leadingEqualToSuperviewTableView = CGFloat(20)
        static let bottomEqualToTableView = CGFloat(-20)
        static let topEqualToSafeAreaLayoutGuideLoginButton = CGFloat(25)
        static let trailingEqualToSafeAreaLayoutGuideLoginButton = CGFloat(-10)
    }
    
    private enum Constants {
        static let fontTitleLabel = CGFloat(21)
        static let widthEqualToSuperviewTableView = CGFloat(0.5)
        static let heightEqualToSuperviewTableView = CGFloat(0.6)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.presenter.view = self
        self.presenter.saveUserLoginSession()
        
        self.setupUI()
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.tableView.dataSource = planetTableViewHandler
        self.tableView.delegate = planetTableViewHandler
        planetTableViewHandler?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updatePlanets(notification: NSNotification) {
        guard let planets = notification.object as? [Planet] else { return }
        self.planetTableViewHandler?.planets = planets
    }
    
    @objc func loginButtonTapped() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserLogIn) {
            showProfileView?()
        } else {
            showAuthView?()
        }
    }
    
    func handleFavouritePlanet(at index: Int, completion: @escaping ((Error?) -> Void)) {
        presenter.handleFavouritePlanet(at: index)
        completion(nil)
    }
    
    func didSelectPlanet(_ planet: Planet) {
        didSelectPlanet?(planet)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

private extension MainView {
    
    func setupUI() {
        configureBackgroundImageView()
        configureTitleLabel()
        configureTableView()
        configureLoginButton()
    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "Planets"
        titleLabel.textColor = .orange
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Overpass-SemiBold", size: Constants.fontTitleLabel)
    }
    
    func configureBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "authBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureTableView() {
        addSubview(tableView)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top).offset(Constraits.bottomEqualToTableView)
        }
        
        tableView.register(PlanetCell.self, forCellReuseIdentifier: PlanetCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperviewTableView)
            make.width.equalToSuperview().multipliedBy(Constants.widthEqualToSuperviewTableView)
            make.height.equalToSuperview().multipliedBy(Constants.heightEqualToSuperviewTableView)
        }
    }
    
    func configureLoginButton() {
        addSubview(loginButton)
        loginButton.setImage(UIImage(systemName: "person"), for: .normal)
        loginButton.tintColor = .orange
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Constraits.topEqualToSafeAreaLayoutGuideLoginButton)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(Constraits.trailingEqualToSafeAreaLayoutGuideLoginButton)
        }
    }
}
