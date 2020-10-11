//
//  UIViewController+Navigation.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 11.10.2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Creates an `UINavigationController` with current view controller as a root.
    /// - Parameters:
    ///   - navigationBarClass: Optional subclass of `UINavigationBar`. If not specified, `UINavigationBar` is used.
    ///   - modalPresentationStyle: Optional type of navigation controller's modal presentation. If not specifed, `UIModalPresentationStyle.automatic` (system default) is used.
    /// - Returns: A configured insance of `UINavigationController` class.
    ///
    /// This method may be useful when app architecture involves usage of **Router**/**Coordinator** modules,
    /// when you need to show a new application flow with navigation stack that starts from a specific initial view controller.
    func embedInNavigationController(navigationBarClass: UINavigationBar.Type? = nil,
                                     modalPresentationStyle: UIModalPresentationStyle = .automatic) -> UINavigationController {
        let nc: UINavigationController
        if let navigationBarClass = navigationBarClass {
            nc = UINavigationController(navigationBarClass: navigationBarClass.self, toolbarClass: nil)
            nc.viewControllers = [self]
        } else {
            nc = UINavigationController(rootViewController: self)
        }
            nc.modalPresentationStyle = modalPresentationStyle
        return nc
    }
}
