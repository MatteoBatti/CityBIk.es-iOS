

import Foundation


extension NSError {
    
    func copy(adding newUserInfo: [String: Any]) -> NSError {
        let updatedUserInfo = self.userInfo.merging(newUserInfo, uniquingKeysWith: {first, last in  first } )
        return NSError(domain: self.domain, code: self.code, userInfo: updatedUserInfo )
    }
    
}
