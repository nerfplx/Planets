import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    var planets: [Planet] { get }
    func loadUserData()
    func saveUserLoginSession()
    func handleUserLogout()
    func handleFavouritePlanet(at index: Int)
}

final class MainViewPresenter: MainViewPresenterProtocol {
    
    private var mainModel = MainModel()
    weak var view: MainViewProtocol?
    var planets: [Planet] {
        return mainModel.planets
    }
    
    init(model: MainModel = MainModel()) {
        self.mainModel = model
        NotificationCenter.default.addObserver(self, selector: #selector(userAuthChanged), name: NSNotification.Name(UserDefaultsKeys.userAuthChangedNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleUserLogout() {
        for planet in planets {
            planet.isFavourite = false
        }
        self.updatePlanets()
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func handleFavouritePlanet(at index: Int) {
        guard let _ = AuthService.shared.currentUser else {
            return
        }
        planets[index].isFavourite.toggle()
        DispatchQueue.main.async { [self] in
            self.updatePlanets()
        }
        let planetNames = planets.filter { $0.isFavourite }.map { $0.title }
        if let userId = AuthService.shared.currentUser?.uid {
            DataBaseService.shared.getUser(id: userId) { (result) in
                switch result {
                case .success(let user):
                    let updatedUser = DefaultUser(id: user.id, name: user.name, phone: user.phone, favouritePlanets: planetNames)
                    DataBaseService.shared.updateUserFavouritePlanets(user: updatedUser, planets: planetNames) { error in
                        if let error = error {
                            print("Error saving favourite planets: \(error)")
                        } else {
                            print("Favourite planets saved successfully.")
                        }
                    }
                case .failure(let error):
                    print("Error fetching user details: \(error)")
                }
            }
        } else {
            print("Current user is not logged in.")
        }
    }
    
    @objc func userAuthChanged() {
        if AuthService.shared.currentUser != nil {
            loadUserData()
        } else {
            handleUserLogout()
        }
    }
    
    func loadUserData() {
        guard let userId = AuthService.shared.currentUser?.uid else {
            return
        }
        DataBaseService.shared.getUser(id: userId) { result in
            switch result {
            case .success(let user):
                let userFavouritePlanets = user.favouritePlanets ?? []
                for planet in self.planets {
                    planet.isFavourite = userFavouritePlanets.contains(where: { $0 == planet.title })
                }
                self.view?.planetTableViewHandler?.planets = self.planets
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch user data: \(error)")
            }
        }
    }
    
    func saveUserLoginSession() {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserLogIn)
        if isUserLoggedIn {
            loadUserData()
        } else {
            for planet in planets {
                planet.isFavourite = false
            }
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
}

extension MainViewPresenter {
    
    func updatePlanets() {
        self.view?.planetTableViewHandler?.planets = self.planets
    }
}
