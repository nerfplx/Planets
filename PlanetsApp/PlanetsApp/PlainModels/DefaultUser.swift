import Firebase

struct DefaultUser: Identifiable {
    
    var id: String = UUID().uuidString
    var name: String
    var phone: String
    var favouritePlanets: [String]?
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["favouritePlanets"] = self.favouritePlanets
        
        return repres
    }
}
