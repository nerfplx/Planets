import UIKit

struct HobbyModel {
    let header: String
    let hobby: String
}

extension HobbyModel {
    init() {
        self.header = "Увлечения"
        self.hobby = "-Волейбол \n-Настольный теннис \n-Сноубординг"
    }
}
