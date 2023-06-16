import Foundation

struct PlanetDetails {
    var meanRadius: Double
    var mass: Mass
    var gravity: Double
    var sideralOrbit: Double
    var sideralRotation: Double
    var avgTemp: Int
    
    var sideralRotationTime: String {
        let hours = Int(sideralRotation)
        let minutes = Int((sideralRotation - Double(hours)) * 60)
        return "\(abs(hours)) h \(abs(minutes)) min"
    }
    
    var avgTempCelsius: Int {
        let kelvin = avgTemp
        let celsium = Int(Double(kelvin) - 273.15)
        return celsium
    }
}
