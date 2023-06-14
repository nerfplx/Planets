import UIKit

class MainView: UIView {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    func setupUI() {
        self.configureLayout()
        self.configureUI()
    }
    
    func configureLayout() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing).inset(16)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .white
    }
}

