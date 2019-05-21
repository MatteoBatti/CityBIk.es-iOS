
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
                let firstCompany = result.companies.first
                XCTAssertEqual(firstCompany?.company, ["Nextbike GmbH"])
                XCTAssertEqual(firstCompany?.href, "/v2/networks/norisbike-nurnberg")
                XCTAssertEqual(firstCompany?.id, "norisbike-nurnberg")
                XCTAssertEqual(firstCompany?.location?.city, "Nürnberg")
                XCTAssertEqual(firstCompany?.location?.country, "DE")
                XCTAssertEqual(firstCompany?.location?.longitude, 11.0814)
                XCTAssertEqual(firstCompany?.location?.latitude, 49.4479)
                XCTAssertEqual(firstCompany?.name, "NorisBike")
            case .error(let error):
                XCTFail("\(error)")
            }
        }
        
    }
    
    func test_api_network_success() {
        
        let jsonData = """
        {
          "network": {
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
            "name": "NorisBike",
            "stations": [
              {
                "empty_slots": 13,
                "extra": {
                  "bike_uids": [
                    "90498",
                    "90497",
                    "90450",
                    "90668"
                  ],
                  "number": "4602",
                  "slots": 17,
                  "uid": "66093"
                },
                "free_bikes": 4,
                "id": "d5e4ca701943a5986142419c92f2ba68",
                "latitude": 49.452632522439,
                "longitude": 11.095933914185,
                "name": "Ohm-Hochschule (Wassertorstr.)",
                "timestamp": "2019-01-31T17:41:34.368000Z"
              },
              {
                "empty_slots": 12,
                "extra": {
                  "bike_uids": [
                    "90159",
                    "90368",
                    "90206",
                    "90409",
                    "90653"
                  ],
                  "number": "4605",
                  "slots": 18,
                  "uid": "66096"
                },
                "free_bikes": 5,
                "id": "2c8dd7616167ab2d00303393d5928377",
                "latitude": 49.453322999397,
                "longitude": 11.07882142067,
                "name": "Heilig-Geist-Spital (Spitalgasse)",
                "timestamp": "2019-01-31T17:41:34.373000Z"
              }
            ]}
        }
        """.data(using: .utf8)
        
        let session = URLSessionMock()
        session.data = jsonData
        
        let networkManager = NetworkManager(session)
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .network(id: "norisbike-nurnberg", parameters: nil))
        } catch {
            XCTFail()
        }
        
        networkManager.request(url) { (result: Result<Company>, response) in
            switch result {
            case .success(let result):
                
                XCTAssertEqual(result.info.company?.first, "Nextbike GmbH")
                XCTAssertEqual(result.info.href, "/v2/networks/norisbike-nurnberg")
                XCTAssertEqual(result.info.id, "norisbike-nurnberg")
                XCTAssertEqual(result.info.location?.city, "Nürnberg")
                XCTAssertEqual(result.info.location?.country, "DE")
                XCTAssertEqual(result.info.location?.latitude, 49.4479)
                XCTAssertEqual(result.info.location?.longitude, 11.0814)
                XCTAssertEqual(result.info.name, "NorisBike")
            
                XCTAssertEqual(result.stations.first?.emptySlots, 13)
                XCTAssertEqual(result.stations.first?.freeBikes, 4)
                XCTAssertEqual(result.stations.first?.name, "Ohm-Hochschule (Wassertorstr.)")
                XCTAssertEqual(result.stations.first?.id, "d5e4ca701943a5986142419c92f2ba68")
                XCTAssertEqual(result.stations.first?.latitude, 49.452632522439)
                XCTAssertEqual(result.stations.first?.longitude, 11.095933914185)
                XCTAssertEqual(result.stations.first?.name, "Ohm-Hochschule (Wassertorstr.)")
                XCTAssertEqual(result.stations.first?.timestamp, "2019-01-31T17:41:34.368000Z")
                
            case .error(let error):
                XCTFail("\(error)")
            }
        }
        
    }
    
}
