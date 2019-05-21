//
//
//  CityBik.es
//  Copyright (c) 2019 Matteo Battistini
//  Licensed under the MIT license, see LICENSE file
//
	

import XCTest
@testable import CityBik_es

class CityBikURLQueryItemTest: XCTestCase {
    
    func test_create_query_parameters_number_success() {
        
        let expectedQueryParams = [URLQueryItem(name: "key", value: "1")]
        let params: Parameters = ["key": 1]
        let queyParams = try? URLQueryItem.items(from: params)
        
        XCTAssertNotNil(queyParams)
        XCTAssertEqual(queyParams, expectedQueryParams)
    }
    
    func test_create_query_parameters_string_array_success() {
    
        let expectedQueryParams = [URLQueryItem(name: "key", value: "param1,param2")]
        let params: Parameters = ["key": ["param1", "param2"]]
        let queyParams = try? URLQueryItem.items(from: params)
        
        XCTAssertNotNil(queyParams)
        XCTAssertEqual(queyParams, expectedQueryParams)
        
    }
    
    func test_create_query_parameters_bool_not_supported() {
        
        let params: Parameters = ["key": true]
        var queyParams: [URLQueryItem]? = nil
        do {
            queyParams = try URLQueryItem.items(from: params)
        } catch URLQueryEncodingError.typeNotSupported {
            
        } catch {
            XCTFail("")
        }
        XCTAssertNil(queyParams)
    }
    
    func test_create_query_parameters_any_array_not_supported() {
        
        let params: Parameters = ["key": [true, "true", 2]]
        var queyParams: [URLQueryItem]? = nil
        do {
            queyParams = try URLQueryItem.items(from: params)
        } catch URLQueryEncodingError.typeNotSupported {
            
        } catch {
            XCTFail("")
        }
        XCTAssertNil(queyParams)
    }
    
}
