

import Foundation


extension Data {
    
    func decode<T: Decodable>(_ decoder: JSONDecoder = JSONDecoder.init(strategy: .convertFromSnakeCase)) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
    
}
