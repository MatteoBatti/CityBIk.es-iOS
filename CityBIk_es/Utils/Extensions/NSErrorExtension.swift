//
//  NSErrorExtension.swift
//  GithubStargazers
//
//  Created by Matteo Battistini on 02/03/2019.
//  Copyright © 2019 matteo.attistini. All rights reserved.
//

import Foundation


extension NSError {
    
    func copy(adding newUserInfo: [String: Any]) -> NSError {
        let updatedUserInfo = self.userInfo.merging(newUserInfo, uniquingKeysWith: {first, last in  first } )
        return NSError(domain: self.domain, code: self.code, userInfo: updatedUserInfo )
    }
    
}
