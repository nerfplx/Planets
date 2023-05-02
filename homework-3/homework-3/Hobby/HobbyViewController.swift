import UIKit
import SnapKit

class HobbyViewController: UIViewController {
    
    private let headerLabel = UILabel()
    private let hobbyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHobbyData()
        self.setupHobbyView()
    }
}

private extension HobbyViewController {
    private enum Constants {
        static let topHeader = 60
        static let topLine = 30
        static let horisontalLeading = 30
    }
    
    func setupHobbyData() {
        self.headerLabel.text = hobbyModel[0]
        self.hobbyLabel.text = hobbyModel[1]
    }
    
    func setupHobbyView() {
        self.configureBackGroundView()
        self.configureTextData()
        self.configureLayout()
        self.configureAnimationUI()
    }
    
    func configureBackGroundView() {
        self.view.backgroundColor = .black
    }
    
    func configureTextData() {
        self.headerLabel.textAlignment = .center
        self.headerLabel.textColor = .white
        self.headerLabel.font = .boldSystemFont(ofSize: 21)
        
        self.hobbyLabel.numberOfLines = 0
        self.hobbyLabel.textAlignment = .left
        self.hobbyLabel.textColor = .white
        self.hobbyLabel.font = .systemFont(ofSize: 18)
    }
    
    func configureLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.topHeader)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(self.hobbyLabel)
        self.hobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constants.topLine)
            make.leading.trailing.equalToSuperview().inset(Constants.horisontalLeading)
        }
    }
    
    func configureAnimationUI() {
        let offset = view.bounds.width
        self.hobbyLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.hobbyLabel.transform = .identity
        }
    }
}

