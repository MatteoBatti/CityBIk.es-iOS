
import Foundation

extension JSONDecoder {
    
    convenience init(strategy: JSONDecoder.KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = strategy
    }
    
}
