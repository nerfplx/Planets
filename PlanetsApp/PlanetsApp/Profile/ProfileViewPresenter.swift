import Foundation

protocol ProfileViewPresenterProtocol: AnyObject {
    func setLogoutButtonAction(_ action: @escaping () -> Void)
    func updateName(name: String)
    func updatePhone(phone: String)
    func updateFavouritePlanet(planet: String)
    func startLoading()
    func stopLoading()
    func userLogOut()
}

final class ProfileViewPresenter {
    
    private weak var view: ProfileViewPresenterProtocol?
    private var authService: AuthService
    private var dataBaseService: DataBaseService
    
    init(view: ProfileViewPresenterProtocol, authService: AuthService, dataBaseService: DataBaseService) {
        self.view = view
        self.authService = authService
        self.dataBaseService = dataBaseService
    }
    
    func viewDidLoad() {
        view?.setLogoutButtonAction(logoutButtonTapped)
        updateProfile()
    }
    
    @objc func logoutButtonTapped() {
        authService.signOut { (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.view?.userLogOut()
                }
            case .failure(let error):
                print("Failed to sign out due to error: \(error)")
            }
        }
    }
}

private extension ProfileViewPresenter {
    
    func updateProfile() {
        guard let currentUserId = authService.currentUser?.uid else { return }
        view?.startLoading()
        dataBaseService.getUser(id: currentUserId) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.view?.updateName(name: user.name)
                    self?.view?.updatePhone(phone: user.phone)
                    if let favouritePlanets = user.favouritePlanets, !favouritePlanets.isEmpty {
                        let favouritePlanetsString = favouritePlanets.joined(separator: "\n")
                        self?.view?.updateFavouritePlanet(planet: "Favourite planets: \n" + favouritePlanetsString)
                    } else {
                        self?.view?.updateFavouritePlanet(planet: "")
                    }
                    self?.view?.stopLoading()
                }
            case .failure(let error):
                print("Failed to get user data: \(error)")
            }
        }
    }
}
