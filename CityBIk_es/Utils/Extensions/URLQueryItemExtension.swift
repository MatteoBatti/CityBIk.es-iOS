

import Foundation

enum URLQueryEncodingError: Error {
    case typeNotSupported
}

extension URLQueryItem {
    
    static func items(from parameters: Parameters) throws -> [URLQueryItem] {
        
        var queryItems: [URLQueryItem] = [URLQueryItem]()
        try parameters.forEach { key, value in
            if let number = value as? NSNumber {
                if number.isBool {
                    throw URLQueryEncodingError.typeNotSupported
                } else {
                    queryItems.append(URLQueryItem(name: key, value: "\(number)" ))
                }
            } else if let array = value as? [String] {
                queryItems.append(URLQueryItem(name: key, value: "\(array.joined(separator: ","))" ))
            } else if let string = value as? String {
                queryItems.append(URLQueryItem(name: key, value: string ))
            } else {
                throw URLQueryEncodingError.typeNotSupported
            }
        }
        return queryItems
    }
}

extension NSNumber {
    fileprivate var isBool: Bool {
        return CFBooleanGetTypeID() == CFGetTypeID(self)
    }
}
