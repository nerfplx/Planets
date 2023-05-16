import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let buttonText = "Detail"
    
    private var nameLabel = UILabel()
    private var imageView = UIImageView()
    private var button = UIButton()
    
    private enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
    }
    
    private enum Constraints {
        static let horizontalImage = 30
        static let topButton = 30
        static let bottomImage = -100
    }
    
    var cell: CollectionCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    @objc func tapButton(_sender: Any) {
        let vc = ModalDetailViewController(nibName: nil, bundle: nil)
        self.present(vc, animated: true)
    }
}

private extension DetailViewController {
    func setupUI() {
        self.configureData()
        self.configureLayout()
        self.setupCell(CollectionCellModel())
    }
    
    func setupCell(_ viewModel: CollectionCellModel) {
        self.nameLabel.text = cell?.name
        if let image = cell?.image {
            self.imageView.image = image
        }
    }
    
    func configureData() {
        self.view.backgroundColor = .black
        
        self.navigationController?.navigationBar.tintColor = .white
        
        self.imageView.contentMode = .scaleAspectFit
        
        self.nameLabel.textAlignment = .left
        self.nameLabel.font = .boldSystemFont(ofSize: 21)
        self.nameLabel.textColor = .white
        self.nameLabel.adjustsFontSizeToFitWidth = true
        
        self.button.setTitle(buttonText, for: .normal)
        self.button.setTitleColor(.white, for: .normal)
        self.button.backgroundColor = .darkGray
        self.button.layer.cornerRadius = Constants.cornerRadius
        self.button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func configureLayout() {
        self.view.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(Constraints.horizontalImage)
        }
        
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(Constraints.bottomImage)
        }
        
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(Constraints.topButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}

