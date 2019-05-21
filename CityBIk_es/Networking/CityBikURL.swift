
import Foundation

typealias Parameters = [String: Any]

enum CityBikAPI {
    case networks(parameters: Parameters?)
    case network(id: String, parameters: Parameters?)
    
    var path: String {
        switch self {
        case .networks:
            return "/v2/networks"
        case .network(let id, _):
            return "/v2/networks/\(id)"
        }
    }
    
    func parameters() throws -> [URLQueryItem]? {
        switch self {
        case .networks(let parameters):
            guard let parameters = parameters else { return nil }
            return try URLQueryItem.items(from: parameters)
        case .network(_, let parameters):
            guard let parameters = parameters else { return nil }
            return try URLQueryItem.items(from: parameters)
        }
    }
}

enum CityBikURLError: Error {
    case invalidParameters(message: String)
}

class CityBikURL {
    
    private static let scheme = "http"
    private static let host   = "api.citybik.es"
    
    class func url(forAPI api:  CityBikAPI) throws -> URL? {
        var components = URLComponents()
        components.scheme = CityBikURL.scheme
        components.host = CityBikURL.host
        components.path = api.path
        components.queryItems = try api.parameters()
        return components.url
    }
    
}

