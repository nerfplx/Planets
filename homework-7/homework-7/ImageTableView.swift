import UIKit

class ImagesTableView: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var imageManager: ImageManager
    private var mainViewController: MainViewController
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init(mainViewController: MainViewController, imageManager: ImageManager) {
        self.mainViewController = mainViewController
        self.imageManager = imageManager
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageManager.imageFileNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: mainViewController.identifier, for: indexPath)
            cell.imageView?.image = nil
            
            cell.contentView.addSubview(activityIndicatorView)
            activityIndicatorView.startAnimating()
            activityIndicatorView.center = cell.contentView.center
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageUrl = self?.imageManager.getImageURL(for: indexPath.row) {
                    if FileManager.default.fileExists(atPath: imageUrl.path) {
                        let image = UIImage(contentsOfFile: imageUrl.path)
                        DispatchQueue.main.async {
                            cell.imageView?.image = image
                            cell.imageView?.contentMode = .scaleAspectFit
                        }
                    } else {
                        print("File not found: \(imageUrl.path)")
                    }
                }
            }
            return cell
        }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mainViewController.deleteImage(at: indexPath)
        }
    }
}
