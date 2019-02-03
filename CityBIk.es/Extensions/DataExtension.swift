//
//
//  CityBik.es
//  Copyright (c) 2019 Matteo Battistini
//  Licensed under the MIT license, see LICENSE file
//

import Foundation


extension Data {
    
    func json() throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
    }
    
}

extension Data {
    
    func decode<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
    
}
