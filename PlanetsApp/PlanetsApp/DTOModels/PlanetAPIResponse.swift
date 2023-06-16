import Foundation

struct PlanetAPIResponse: Codable {
    
    let meanRadius: Double
    let mass: Mass
    let gravity: Double
    let sideralOrbit: Double
    let sideralRotation: Double
    let avgTemp: Int
}

struct Mass: Codable {
    let massValue: Double
    let massExponent: Int
}
