import UIKit

protocol PlanetTableViewHandlerDelegate: AnyObject {
    func didSelectPlanet(_ planet: Planet)
    func handleFavouritePlanet(at index: Int, completion: @escaping ((Error?) -> Void))
}

final class PlanetTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: PlanetTableViewHandlerDelegate?
    var planets: [Planet] = MainModel().planets
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanetCell.identifier, for: indexPath) as! PlanetCell
        cell.configure(with: planets[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectPlanet(planets[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favouriteAction = UIContextualAction(style: .normal, title: "Favourite") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            self.delegate?.handleFavouritePlanet(at: indexPath.row) { error in
                if error == nil {
                    DispatchQueue.main.async {
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                completionHandler(true)
            }
        }
        favouriteAction.image = UIImage(systemName: "heart")
        favouriteAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [favouriteAction])
    }
}
