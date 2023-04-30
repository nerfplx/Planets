import UIKit
import SnapKit

class HobbyViewController: UIViewController {
    
    private let headerLabel = UILabel()
    private let hobbyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSoftSkillsData(HobbyModel())
        self.setupSoftSkillsView()
    }
}

private extension HobbyViewController {
    private enum Constraints {
        static let topHeader = 60
        static let topLine = 30
        static let horisontalLeading = 30
    }
    
    func setupSoftSkillsData(_ viewModel: HobbyModel) {
        self.headerLabel.text = viewModel.header
        self.hobbyLabel.text = viewModel.hobby
    }
    
    func setupSoftSkillsView() {
        self.setupBackGroundView()
        self.setupCommonData()
        self.setupLayout()
        self.setupAnimationUI()
    }
    
    func setupBackGroundView() {
        self.view.backgroundColor = .black
    }
    
    func setupCommonData() {
        self.headerLabel.textAlignment = .center
        self.headerLabel.textColor = .white
        self.headerLabel.font = .boldSystemFont(ofSize: 21)
        
        self.hobbyLabel.numberOfLines = 0
        self.hobbyLabel.textAlignment = .left
        self.hobbyLabel.textColor = .white
        self.headerLabel.font = .systemFont(ofSize: 18)
    }
    
    func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topHeader)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeading)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(self.hobbyLabel)
        self.hobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constraints.topLine)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeading)
        }
    }
    
    func setupAnimationUI() {
        self.animateUILabel()
    }
    
    func animateUILabel() {
        let offset = view.bounds.width
        self.hobbyLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.hobbyLabel.transform = .identity
        }
    }
}

