import UIKit
import SnapKit

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let identifier = "Cell"
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var imageUrls = [URL]()
    private let network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        self.setupUI()
    }
}

extension MainViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let urlString = searchBar.text, let url = URL(string: urlString) else {
            self.presentInvalidURLAlert()
            return
        }
        network.downloadImage(from: url) { result in
            switch result {
            case .success(let data):
                self.handleImageData(data, for: url)
            case .failure(let error):
                self.presentErrorAlert(error.localizedDescription)
            }
        }
    }
    
    func handleImageData(_ data: Data, for url: URL) {
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.addImageURL(url, image: image)
            }
        }
    }
    func addImageURL(_ url: URL, image: UIImage) {
        imageUrls.append(url)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension MainViewController {
    func presentInvalidURLAlert() {
        let alert = UIAlertController(title: "Invalid URL", message: "Please enter a valid URL", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MainViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath)
        cell.imageView?.image = nil
        
        let url = self.imageUrls[indexPath.row]
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        cell.contentView.addSubview(activityIndicatorView)
        activityIndicatorView.center = cell.contentView.center
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        }
        return cell
    }
}


extension MainViewController {
    func setupUI() {
        self.configureLayout()
        self.configureUI()
    }
    
    func configureLayout() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
    }
}



