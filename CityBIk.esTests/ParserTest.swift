

import XCTest
@testable import CityBIk_es

class CityBikesJsonParserTest: XCTestCase {
    
    func test_parseNetworks_allFields() {
        
        let json = """
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
        
        guard let jsonData = json else {
            XCTFail("json data cannot be nil")
            return
        }
        
        var networks: BikeNetworks? = nil
        do {
            networks = try jsonData.decode()
        } catch let error {
            XCTFail("parser error: \(error.localizedDescription)")
        }
        
        XCTAssertNotNil(networks)
        
        let firstCompany = networks?.companies.first
        XCTAssertEqual(firstCompany?.company?.first, "Nextbike GmbH")
        XCTAssertEqual(firstCompany?.href, "/v2/networks/norisbike-nurnberg")
        XCTAssertEqual(firstCompany?.id, "norisbike-nurnberg")
        XCTAssertEqual(firstCompany?.location?.city, "Nürnberg")
        XCTAssertEqual(firstCompany?.location?.country, "DE")
        XCTAssertEqual(firstCompany?.location?.latitude, 49.4479)
        XCTAssertEqual(firstCompany?.location?.longitude, 11.0814)
        XCTAssertEqual(firstCompany?.name, "NorisBike")
    }
    
    func test_parseNetworks_filteredFields() {
        
        let json = """
           {
              "networks": [
                {
                  "href": "/v2/networks/norisbike-nurnberg",
                  "id": "norisbike-nurnberg",
                  "name": "NorisBike"
                },
                {
                  "href": "/v2/networks/sz-bike-dresden",
                  "id": "sz-bike-dresden",
                  "name": "sz-bike"
                }
            ]

        }
        """.data(using: .utf8)
        
        guard let jsonData = json else {
            XCTFail("json data cannot be nil")
            return
        }
        
        var networks: BikeNetworks? = nil
        do {
            networks = try jsonData.decode()
        } catch let error {
            XCTFail("parser error: \(error.localizedDescription)")
        }
        
        XCTAssertNotNil(networks)
        
        let firstCompany = networks?.companies.first
        XCTAssertNil(firstCompany?.company)
        XCTAssertEqual(firstCompany?.href, "/v2/networks/norisbike-nurnberg")
        XCTAssertEqual(firstCompany?.id, "norisbike-nurnberg")
        XCTAssertNil(firstCompany?.location)
        XCTAssertEqual(firstCompany?.name, "NorisBike")
    }
    
    
    func test_parseStations() {
        let json = """
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
        
        guard let jsonData = json else {
            XCTFail("json data cannot be nil")
            return
        }
        
        
        var company: Company? = nil
        do {
            company = try jsonData.decode()
        } catch let error {
            XCTFail("parser error: \(error.localizedDescription)")
        }
        
        XCTAssertNotNil(company)
        
        XCTAssertEqual(company?.info.company?.first, "Nextbike GmbH")
        XCTAssertEqual(company?.info.href, "/v2/networks/norisbike-nurnberg")
        XCTAssertEqual(company?.info.id, "norisbike-nurnberg")
        XCTAssertEqual(company?.info.location?.city, "Nürnberg")
        XCTAssertEqual(company?.info.location?.country, "DE")
        XCTAssertEqual(company?.info.location?.latitude, 49.4479)
        XCTAssertEqual(company?.info.location?.longitude, 11.0814)
        XCTAssertEqual(company?.info.name, "NorisBike")
        
        XCTAssertEqual(company?.stations.first?.empty_slots, 13)
        XCTAssertEqual(company?.stations.first?.free_bikes, 4)
        XCTAssertEqual(company?.stations.first?.name, "Ohm-Hochschule (Wassertorstr.)")
        XCTAssertEqual(company?.stations.first?.id, "d5e4ca701943a5986142419c92f2ba68")
        XCTAssertEqual(company?.stations.first?.latitude, 49.452632522439)
        XCTAssertEqual(company?.stations.first?.longitude, 11.095933914185)
        XCTAssertEqual(company?.stations.first?.name, "Ohm-Hochschule (Wassertorstr.)")
        XCTAssertEqual(company?.stations.first?.timestamp, "2019-01-31T17:41:34.368000Z")
        
    }
    
}
