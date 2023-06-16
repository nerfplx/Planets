import UIKit
import SwiftUI

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private var presenter: MainViewPresenterProtocol = MainViewPresenter()
    
    init(presenter: MainViewPresenterProtocol = MainViewPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.orange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAuthView()
        self.showProfileView()
        self.showDetailView()
        self.handleLogoutPresenter()
        NotificationCenter.default.addObserver(self, selector: #selector(userAuthChanged), name: NSNotification.Name(UserDefaultsKeys.userAuthChangedNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showAuthView() {
        mainView.showAuthView = { [weak self] in
            let authPresenter = AuthPresenter()
            let authView = AuthView().environmentObject(authPresenter)
            let hostingController = UIHostingController(rootView: authView)
            self?.present(hostingController, animated: true, completion: nil)
        }
    }
    
    func showProfileView() {
        self.mainView.showProfileView = { [weak self] in
            let profileView = ProfileViewController()
            self?.present(profileView, animated: true, completion: nil)
        }
    }
    
    func showDetailView() {
        mainView.didSelectPlanet = { [weak self] planet in
            let planetModel = PlanetModel(planet: planet)
            let detailViewController = PlanetDetailViewController(planet: planetModel)
            self?.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    @objc func userAuthChanged() {
        if !UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserLogIn) {
            presenter.handleUserLogout()
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        } else {
            self.presenter.loadUserData()
        }
    }
}

extension MainViewController {
    
    func handleLogoutPresenter() {
        if !UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserLogIn) {
            presenter.handleUserLogout()
        }
    }
}
