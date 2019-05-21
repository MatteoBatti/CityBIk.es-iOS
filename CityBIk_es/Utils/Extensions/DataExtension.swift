//
//  DataExtension.swift
//  GithubStargazers
//
//  Created by Matteo Battistini on 26/02/2019.
//  Copyright © 2019 matteo.attistini. All rights reserved.
//

import Foundation


extension Data {
    
    func decode<T: Decodable>(_ decoder: JSONDecoder = JSONDecoder.init(strategy: .convertFromSnakeCase)) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
    
}
