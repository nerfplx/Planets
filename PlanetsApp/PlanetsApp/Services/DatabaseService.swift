import Foundation
import FirebaseFirestore

final class DataBaseService {
    
    static let shared = DataBaseService()
    private let db = Firestore.firestore()
    private let usersDB = "users"
    
    private var usersRef: CollectionReference {
        return db.collection(usersDB)
    }
    
    private init () {}
    
    func createUser(user: DefaultUser, completion: @escaping (Result<DefaultUser, Error>) -> Void) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUser(id: String, completion: @escaping (Result<DefaultUser, Error>) -> Void) {
        usersRef.document(id).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists, let data = document.data() {
                guard let name = data["name"] as? String,
                      let phone = data["phone"] as? String else {
                    return
                }
                let favouritePlanets = data["favouritePlanets"] as? [String] ?? []
                let user = DefaultUser(id: id, name: name, phone: phone, favouritePlanets: favouritePlanets)
                completion(.success(user))
            } else {
            }
        }
    }
    
    func updateUserFavouritePlanets(user: DefaultUser, planets: [String], completion: @escaping (Error?) -> Void) {
        let usersRef = Firestore.firestore().collection(usersDB)
        usersRef.document(user.id).updateData(["favouritePlanets": planets]) { error in
            completion(error)
        }
    }
}

