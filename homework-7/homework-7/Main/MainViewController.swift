import UIKit
import SnapKit

final class MainViewController: UIViewController, UISearchBarDelegate {
    
    let identifier = "Cell"
    
    private var imageManager = ImageManager()
    private var network: NetworkService?
    private var search: Search?
    private var alerts: Alerts?
    private var tableView: ImagesTableView?
    private var customView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.customView
        
        self.network = NetworkService(imageManager: imageManager)
        self.search = Search(imageManager: imageManager, network: network ?? NetworkService(imageManager: imageManager))
        self.alerts = Alerts(viewController: self)
        self.tableView = ImagesTableView(mainViewController: self, imageManager: imageManager)
        
        self.customView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        self.customView.tableView.dataSource = self.tableView
        self.customView.tableView.delegate = self.tableView
        self.customView.searchBar.delegate = self
        
        self.imageManager.loadImageFileNames()
    }
}

extension MainViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let urlString = searchBar.text, let url = URL(string: urlString) else {
            self.alerts?.presentInvalidURLAlert()
            return
        }
        search?.performSearch(with: url, completion: {
            DispatchQueue.main.async {
                self.customView.tableView.reloadData()
            }
        }, failure: { error in
            self.alerts?.presentErrorAlert(error)
        })
    }
    
    func deleteImage(at indexPath: IndexPath) {
        imageManager.deleteImage(at: indexPath.row)
        
        DispatchQueue.main.async { [weak self] in
            self?.customView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
