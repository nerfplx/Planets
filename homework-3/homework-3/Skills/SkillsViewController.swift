import UIKit
import SnapKit

class SkillsViewController: UIViewController {
    
    private let headerLabel = UILabel()
    private let skillsLabel = UILabel()
    private let experienceLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHardSkillsData(SkillsModel())
        self.setupHardSkillsView()
    }
}

private extension SkillsViewController {
    private enum Constraints {
        static let topHeader = 60
        static let topSkill = 30
        static let topLine = 7
        static let horisontalLeading = 30
    }
    
    func setupHardSkillsData(_ viewModel: SkillsModel) {
        self.headerLabel.text = viewModel.header
        self.skillsLabel.text = viewModel.skills
        self.experienceLabel.text = viewModel.experience
    }
    
    func setupHardSkillsView() {
        self.setupBackGroundView()
        self.setupCommonData()
        self.setupLayout()
        self.animateUILabel()
    }
    func setupBackGroundView() {
        self.view.backgroundColor = .black
    }
    
    func setupCommonData() {
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
    
    func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topHeader)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeading)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.skillsLabel)
        self.skillsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constraints.topSkill)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeading)
        }
        
        self.view.addSubview(self.experienceLabel)
        self.experienceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.skillsLabel.snp.bottom).offset(Constraints.topLine)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeading)
        }
    }
    
    func animateUILabel() {
        let offset = view.bounds.width
        self.skillsLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.experienceLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.skillsLabel.transform = .identity
            self.experienceLabel.transform = .identity
        }
    }
}

