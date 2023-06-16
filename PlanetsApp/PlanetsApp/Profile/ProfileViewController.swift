import UIKit

final class ProfileViewController: UIViewController, ProfileViewPresenterProtocol {
    
    private let profileView = ProfileView()
    private var presenter: ProfileViewPresenter?
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfileViewPresenter(view: self, authService: AuthService.shared, dataBaseService: DataBaseService.shared)
        presenter?.viewDidLoad()
    }
}

extension ProfileViewController {
    
    func setLogoutButtonAction(_ action: @escaping () -> Void) {
        profileView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped() {
        presenter?.logoutButtonTapped()
    }
    
    func updateName(name: String) {
        profileView.nameLabel.text = name
    }
    
    func updatePhone(phone: String) {
        profileView.phoneLabel.text = phone
    }
    
    func updateFavouritePlanet(planet: String) {
        profileView.favouritePlanetLabel.text = planet
        profileView.favouritePlanetLabel.numberOfLines = 0
    }
    
    func startLoading() {
        profileView.activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        profileView.activityIndicator.stopAnimating()
    }
    
    func userLogOut() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isUserLogIn)
        NotificationCenter.default.post(name: NSNotification.Name(UserDefaultsKeys.userAuthChangedNotification), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
