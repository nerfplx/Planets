import Foundation
import FirebaseFirestore

final class Planet: Codable {
    var title: String
    var imageUrl: String
    var isFavourite: Bool = false

    init(title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
    }
}
