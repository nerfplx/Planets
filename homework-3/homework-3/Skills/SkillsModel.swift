import Foundation


struct SkillsModel {
    let header: String
    let skills: [String]
    let experience: String
}


extension SkillsModel {
    init() {
        self.header = "Навыки"
        self.skills = ["-Swift",
                       "UIKit",
                       "Xcode",
                       "Git"]
        self.experience = "Изучаю Swift около года. Подал заявку на курс с целью улучшить свои навыки, также буду рад дальнейшему сотрудничеству"
    }
}

