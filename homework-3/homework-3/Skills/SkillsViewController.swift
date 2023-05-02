import UIKit
import SnapKit

class SkillsViewController: UIViewController {
    
    private let headerLabel = UILabel()
    private let skillsLabel = UILabel()
    private let experienceLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSkillsData()
        self.setupSkillsView()
    }
}

private extension SkillsViewController {
    private enum Constants {
        static let topHeader = 60
        static let topSkill = 30
        static let topLine = 7
        static let horisontalLeading = 30
    }
    
    func setupSkillsData() {
        self.headerLabel.text = skillModel[0]
        self.skillsLabel.text = skillModel[1]
        self.experienceLabel.text = skillModel[2]
    }
    
    func setupSkillsView() {
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
        
        self.skillsLabel.numberOfLines = 0
        self.skillsLabel.textAlignment = .left
        self.skillsLabel.textColor = .white
        self.skillsLabel.font = .systemFont(ofSize: 18)
        
        self.experienceLabel.numberOfLines = 0
        self.experienceLabel.textAlignment = .natural
        self.experienceLabel.textColor = .white
        self.experienceLabel.font = .systemFont(ofSize: 18)
    }
    
    func configureLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.topHeader)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(self.skillsLabel)
        self.skillsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constants.topSkill)
            make.leading.trailing.equalToSuperview().inset(Constants.horisontalLeading)
        }
        self.view.addSubview(self.experienceLabel)
        self.experienceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.skillsLabel.snp.bottom).offset(Constants.topLine)
            make.leading.trailing.equalToSuperview().inset(Constants.horisontalLeading)
        }
    }
    
    func configureAnimationUI() {
        let offset = view.bounds.width
        self.skillsLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.experienceLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.skillsLabel.transform = .identity
            self.experienceLabel.transform = .identity
        }
    }
}

