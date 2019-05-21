//
//  JSONDecoderExtension.swift
//  GithubStargazers
//
//  Created by Matteo Battistini on 26/02/2019.
//  Copyright © 2019 matteo.attistini. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    convenience init(strategy: JSONDecoder.KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = strategy
    }
    
}
