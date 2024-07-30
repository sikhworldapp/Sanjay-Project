//
//  Views_Utility.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 26/07/24.
//


import UIKit

extension UIView {
    func addTapGesture(closure: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        // Store the closure in an associated object
        objc_setAssociatedObject(self, &AssociatedKeys.tapClosure, closure, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    @objc private func handleTap() {
        // Retrieve and execute the closure
        if let closure = objc_getAssociatedObject(self, &AssociatedKeys.tapClosure) as? () -> Void {
            closure()
        }
    }
}

// Define a key for associated objects
private struct AssociatedKeys {
    static var tapClosure = "tapClosure"
}


extension UIView {
    @IBInspectable var forceRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
           
        }
    }
}
