//
//
//  CityBik.es
//  Copyright (c) 2019 Matteo Battistini
//  Licensed under the MIT license, see LICENSE file
//
	

import XCTest
@testable import CityBik_es


class CityBikURLTest: XCTestCase {
    
    // MARK: Networks
    func testCreateValidURL() {
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .networks(parameters: nil))
        } catch {
            XCTFail()
        }
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "http://api.citybik.es/v2/networks")
    }
    
    func testCreateValidIntURLParam() {
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .networks(parameters: ["key": 3]))
        } catch {
            XCTFail()
        }
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "http://api.citybik.es/v2/networks?key=3")
    }
    
    func testCreateValidArrayURLParam() {
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .networks(parameters: ["fields": ["id", "name"]]))
        } catch {
            XCTFail()
        }
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "http://api.citybik.es/v2/networks?fields=id,name")
    }
    
    func testCreateInvalidURLParams() {
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .networks(parameters: ["test": true]))
        } catch {
            
        }
        
        XCTAssertNil(url)
    }
    
    // MARK: Networks
    
    func testCreateValidNetworkURL() {
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .network(id: "1234", parameters: nil))
        } catch {
            XCTFail()
        }
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "http://api.citybik.es/v2/networks/1234")
    }
    
    func testCreateValidNetworkURLAndParameters() {
        
        var url: URL? = nil
        do {
            url = try CityBikURL.url(forAPI: .network(id: "1234", parameters: ["fields": "name"]))
        } catch {
            XCTFail()
        }
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "http://api.citybik.es/v2/networks/1234?fields=name")
    }
}
