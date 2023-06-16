import UIKit

final class PlanetDetailViewController: UIViewController, PlanetDetailViewProtocol {
    
    private let detailView: PlanetDetailView
    private var presenter: PlanetDetailPresenter!
    
    init(planet: PlanetModel) {
        self.detailView = PlanetDetailView(frame: .zero, planetModel: planet)
        super.init(nibName: nil, bundle: nil)
        self.presenter = PlanetDetailPresenter(view: self, planet: planet)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadPlanetDetails()
    }
}

extension PlanetDetailViewController {
    
    func showPlanetDetails(with planet: PlanetModel) {
        detailView.configure(with: planet)
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
