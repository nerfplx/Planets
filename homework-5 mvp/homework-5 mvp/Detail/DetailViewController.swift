import UIKit

protocol DetailViewProtocol: AnyObject {
    func displayItemDetails(_ item: Item)
}

class DetailViewController: UIViewController, DetailViewProtocol {
    private var nameLabel = UILabel()
    private var imageView = UIImageView()
    private var button = UIButton()
    private let presenter: DetailPresenterProtocol
    private let buttonText = "Detail"
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        presenter.viewDidLoad()
    }
    
    @objc func tapButton(_sender: Any) {
        let vc = ModalDetailViewController(nibName: nil, bundle: nil)
        self.present(vc, animated: true)
    }
}

private extension DetailViewController {
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
    
    func setupUI() {
        self.configureData()
        self.configureLayout()
    }
    
    private func configureData() {
        self.view.backgroundColor = .black
        
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

extension DetailViewController {
    func displayItemDetails(_ item: Item) {
        nameLabel.text = item.name
        imageView.image = item.image
    }
}

