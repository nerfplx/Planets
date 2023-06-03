import Foundation

class ImageManager {
    
    var imageFileNames: [String] = []
    
    func saveImageData(_ data: Data) throws -> URL {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = UUID().uuidString.appending(".jpg")
        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        try data.write(to: fileUrl)
        return fileUrl
    }
    
    func saveImageLink(_ link: URL) {
        let fileName = link.lastPathComponent
        imageFileNames.append(fileName)
        saveImageFileNames()
    }
    
    func deleteImage(at index: Int) {
        if let imageUrl = getImageURL(for: index) {
            if FileManager.default.fileExists(atPath: imageUrl.path) {
                do {
                    try FileManager.default.removeItem(at: imageUrl)
                } catch {
                    print("Failed to delete image file: \(error)")
                }
            }
            imageFileNames.remove(at: index)
            saveImageFileNames()
            UserDefaults.standard.synchronize()
        } else {
            print("Failed to get the image URL")
        }
    }
    
    func saveImageFileNames() {
        UserDefaults.standard.set(imageFileNames, forKey: "imageFileNames")
        UserDefaults.standard.synchronize()
    }
    
    func loadImageFileNames() {
        if let fileNames = UserDefaults.standard.array(forKey: "imageFileNames") as? [String] {
            self.imageFileNames = fileNames
        } else {
            print("Not found imageFileNames in UserDefaults")
        }
    }
    
    func getImageURL(for index: Int) -> URL? {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = imageFileNames[index]
        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        return fileUrl
    }
}
