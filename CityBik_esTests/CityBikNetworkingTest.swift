
import XCTest
@testable import CityBik_es

class CityBikNetworkTest: XCTestCase {
    
    func test_api_networks_success() {
        
        let jsonData = """
           {
              "networks": [
                {
                  "company": [
                    "Nextbike GmbH"
                  ],
                  "href": "/v2/networks/norisbike-nurnberg",
                  "id": "norisbike-nurnberg",
                  "location": {
                    "city": "Nürnberg",
                    "country": "DE",
                    "latitude": 49.4479,
                    "longitude": 11.0814
                  },
                  "name": "NorisBike"
                },
                {
                  "company": [
                    "Nextbike GmbH"
                  ],
                  "href": "/v2/networks/sz-bike-dresden",
                  "id": "sz-bike-dresden",
                  "location": {
                    "city": "Dresden",
                    "country": "DE",
                    "latitude": 51.0535,
                    "longitude": 13.7387
                  },
                  "name": "sz-bike"
                }
            ]

        }
        """.data(using: .utf8)
        
        let session = URLSessionMock()
        session.data = jsonData
        
        let networkManager = NetworkManager(session)
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .networks(parameters: nil))
        } catch {
            XCTFail()
        }
        
        networkManager.request(url) { (result: Result<BikeNetworks>, response) in
            switch result {
            case .success(let result):
                XCTFail()
            case .error(let error):
                XCTFail("\(error)")
            }
        }
        
    }
    
}
