import Alamofire
import Foundation

final class NetworkService {
    
    private let baseURL = "https://api.le-systeme-solaire.net/rest"
    
    func fetchPlanetDetails(planetName: String, completion: @escaping (Result<PlanetAPIResponse, Error>) -> Void) {
        let url = baseURL + "/bodies/\(planetName)"
        AF.request(url).validate().responseDecodable(of: PlanetAPIResponse.self) { response in
            switch response.result {
            case .success(let planetAPIResponse):
                completion(.success(planetAPIResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
