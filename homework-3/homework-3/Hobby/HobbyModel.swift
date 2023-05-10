import Foundation



struct HobbyModel {
    let header: String
    let hobbies: [String]
}

extension HobbyModel {
    init() {
        self.header = "Увлечения"
        self.hobbies = ["-Волейбол",
                      "Настольный теннис",
                      "Сноубординг"]
    }
}


