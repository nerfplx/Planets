import Foundation

final class PlanetDetailPresenter {
    private weak var view: PlanetDetailViewProtocol?
    private let networkService: NetworkService
    private var planetModel: PlanetModel
    
    init(view: PlanetDetailViewProtocol, planet: PlanetModel, networkService: NetworkService = NetworkService()) {
        self.view = view
        self.planetModel = planet
        self.networkService = networkService
    }
    
    func loadPlanetDetails() {
        networkService.fetchPlanetDetails(planetName: planetModel.planet.title) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let planetAPIResponse):
                let planetDetails = PlanetDetails(
                    meanRadius: planetAPIResponse.meanRadius,
                    mass: planetAPIResponse.mass,
                    gravity: planetAPIResponse.gravity,
                    sideralOrbit: planetAPIResponse.sideralOrbit,
                    sideralRotation: planetAPIResponse.sideralRotation,
                    avgTemp: planetAPIResponse.avgTemp
                )
                self.planetModel.details = planetDetails
                
                DispatchQueue.main.async {
                    self.view?.showPlanetDetails(with: self.planetModel)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError(error: error)
                }
            }
        }
    }
}
