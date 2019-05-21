

import UIKit

extension UIView {
    
    func match(_ view: UIView) {
        NSLayoutConstraint.activate(
            [self.topAnchor.constraint(equalTo: view.topAnchor),
             self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             self.leadingAnchor.constraint(equalTo: view.leadingAnchor)]
        )
    }
    
}
