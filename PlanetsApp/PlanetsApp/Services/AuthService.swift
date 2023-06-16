import Foundation
import FirebaseAuth

final class AuthService {
    
    static let shared = AuthService()
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    func registerUser(email: String, password: String, name: String, phone: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                let userDefault = DefaultUser(id: result.user.uid, name: name, phone: phone)
                DataBaseService.shared.createUser(user: userDefault) { resultDB in
                    switch resultDB {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                self.setUserLoggedInStatus(true)
                completion(.success(result.user))
                NotificationCenter.default.post(name: NSNotification.Name(UserDefaultsKeys.userAuthChangedNotification), object: nil)
            } else if let error = error {
                self.setUserLoggedInStatus(false)
                completion(.failure(error))
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            setUserLoggedInStatus(false)
            completion(.success(()))
        } catch let signOutError {
            completion(.failure(signOutError))
        }
    }
    
    private func setUserLoggedInStatus(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: UserDefaultsKeys.isUserLogIn)
    }
}
