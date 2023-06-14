import Foundation

class Search {
    private let imageManager: ImageManager
    private let network: NetworkService?
    
    init(imageManager: ImageManager, network: NetworkService) {
        self.imageManager = imageManager
        self.network = network
    }

    func performSearch(with url: URL, completion: @escaping () -> Void, failure: @escaping (String) -> Void) {
        network?.downloadImage(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let fileUrl = try self?.imageManager.saveImageData(data)
                    self?.imageManager.saveImageLink(fileUrl ?? URL(fileURLWithPath: "Failed to save imageLink"))
                    completion()
                } catch {
                    print("Failed to save imageData: \(error)")
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
