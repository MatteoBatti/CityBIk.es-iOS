

import UIKit

extension UIViewController {
    
    func add(childController: UIViewController?, toView view: UIView?) {
        guard let childController = childController, let view = view else { return }
        self.addChild(childController)
        childController.beginAppearanceTransition(true, animated: true)
        childController.willMove(toParent: self)
        childController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childController.view)
        childController.endAppearanceTransition()
        childController.didMove(toParent: self)
        childController.view.match(view)
    }
    

    func remove(childController: UIViewController?) {
        guard let childController = childController else { return }
        childController.willMove(toParent: nil)
        childController.beginAppearanceTransition(false, animated: true)
        childController.view.removeFromSuperview()
        childController.endAppearanceTransition()
        childController.removeFromParent()
    }
    
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

