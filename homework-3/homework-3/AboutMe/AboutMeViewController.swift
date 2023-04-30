import UIKit

class AboutMeViewController: UIViewController {
    
    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var surnameLabel: UILabel!
    @IBOutlet private var ageLabel: UILabel!
    @IBOutlet private var educationLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAboutMeData(AboutMeModel())
        self.setupAboutMeView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animateUILabel()
    }
}

extension AboutMeViewController {
    func setupAboutMeData(_ viewModel: AboutMeModel) {
        self.headerLabel.text = viewModel.header
        self.nameLabel.text = viewModel.name
        self.surnameLabel.text = viewModel.surname
        self.ageLabel.text = viewModel.age
        self.educationLabel.text = viewModel.education
        self.cityLabel.text = viewModel.city
    }
    
    func setupAboutMeView() {
        self.setupCommonData()
        self.animateUILabel()
    }
    
    func setupCommonData() {
        self.headerLabel.textAlignment = .left
        self.headerLabel.textColor = .white
        self.headerLabel.font = .boldSystemFont(ofSize: 21)
        
        self.nameLabel.textAlignment = .left
        self.nameLabel.textColor = .white
        self.nameLabel.font = .systemFont(ofSize: 18)
        
        self.surnameLabel.textAlignment = .left
        self.surnameLabel.textColor = .white
        self.surnameLabel.font = .systemFont(ofSize: 18)
        
        self.ageLabel.textAlignment = .left
        self.ageLabel.textColor = .white
        self.ageLabel.font = .systemFont(ofSize: 18)
        
        self.educationLabel.numberOfLines = 0
        self.educationLabel.textAlignment = .left
        self.educationLabel.textColor = .white
        self.educationLabel.font = .systemFont(ofSize: 18)
        
        self.cityLabel.textAlignment = .left
        self.cityLabel.textColor = .white
        self.cityLabel.font = .systemFont(ofSize: 18)
    }
    
    func animateUILabel() {
        let offset = view.bounds.width
        self.nameLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.surnameLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.ageLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.educationLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.cityLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.nameLabel.transform = .identity
            self.surnameLabel.transform = .identity
            self.ageLabel.transform = .identity
            self.educationLabel.transform = .identity
            self.cityLabel.transform = .identity
        }
    }
}
