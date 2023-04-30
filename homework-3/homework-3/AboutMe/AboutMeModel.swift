import UIKit

struct AboutMeModel {
    let header: String
    let avatar: UIImage?
    let name: String
    let surname: String
    let age: String
    let education: String
    let city: String
}

extension AboutMeModel {
    init() {
        self.header = "Обо мне"
        self.avatar = UIImage(named: "avatar")
        self.name = "Имя: Александр"
        self.surname = "Фамилия: Платонов"
        self.age = "Возраст: 28 лет"
        self.education = "Образование: СГУПС. Факультет бизнес-информатики"
        self.city = "Город: Новосибирск"
    }
}
