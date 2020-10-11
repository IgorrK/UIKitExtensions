//
//  UIViewController+Style.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 11.10.2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Sets background color for the view.
    ///
    /// - Parameters:
    ///   - color: Background color.
    /// - Returns: Updated object.
    @discardableResult
    func backgroundColorStyle(_ color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }
    
    /// Sets back button for view controller's navigation bar.
    ///
    /// - Parameter barButtonItem: Navigation bar button.
    /// - Returns: Updated object.
    @discardableResult
    func backNavigationBarButtonStyle(_ barButtonItem: UIBarButtonItem) -> Self {
        navigationItem.backBarButtonItem = barButtonItem
        return self
    }
    
    /// Sets back buttom with empty title for view controller's navigation bar.
    ///
    /// - Returns: Updated object.
    @discardableResult
    func emptyBackNavigationBarButtonStyle() -> Self {
        let button = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return backNavigationBarButtonStyle(button)
    }
}
