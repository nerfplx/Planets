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
        self.configureAnimationUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureAnimationUI()
    }
}

private extension AboutMeViewController {
    func configureAnimationUI() {
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
