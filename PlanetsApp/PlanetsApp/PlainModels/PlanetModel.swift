import Foundation
import UIKit

final class PlanetModel {
    
    var planet: Planet
    var details: PlanetDetails?
    
    init (planet: Planet) {
        self.planet = planet
    }
}
