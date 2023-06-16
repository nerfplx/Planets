import Foundation
import CoreData
import UIKit

class CoreDataService {
        
    static let shared = CoreDataService()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    func addPlanetToFavourites(_ planet: Planet) {
        let entity = NSEntityDescription.entity(forEntityName: "PlanetsApp", in: context)
        let newPlanet = NSManagedObject(entity: entity!, insertInto: context)

        newPlanet.setValue(planet.title, forKey: "title")
        newPlanet.setValue(planet.imageUrl, forKey: "imageUrl")

        do {
            try context.save()
        } catch let error {
            print("Failed saving planet. Error: \(error)")
        }
    }
    
    func loadFavouritePlanets() -> [Planet] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlanetsApp")
        var planets: [Planet] = []

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let imageUrl = data.value(forKey: "imageUrl") as! String
                planets.append(Planet(title: title, imageUrl: imageUrl))
            }
        } catch let error {
            print("Failed to load planets. Error: \(error)")
        }
        return planets
    }
    
    func removePlanetFromFavourites(_ planet: Planet) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlanetsApp")
        request.predicate = NSPredicate(format: "title = %@", planet.title)

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch let error {
            print("Failed to remove planet. Error: \(error)")
        }
    }
}
