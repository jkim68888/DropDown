import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        _ = views.map { self.addSubview($0) }
    }
    
    func viewContainingController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
}
