//
//  UIView+Style.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 10.10.2020.
//

import UIKit
import Foundation

/// Functional-like API for style customization of `UIView` and its subclasses.
/// This is a general approach which can be adjusted for each specific project.
extension UIView {
    private struct Constants {
        static let defaultCornerRadius: CGFloat = 5.0
    }

    /// Draws rounded corners.
    ///
    /// - Parameter radius: Corner radius.
    /// - Returns: Updated object.
    @discardableResult
    func roundedCornersStyle(radius: CGFloat = Constants.defaultCornerRadius) -> Self {
        clipsToBounds = true
        layer.cornerRadius = radius
        return self
    }
    
    /// Draws rounded corners with radius = `self.bounds.height / 2.0`,
    /// creating a circle view border.
    ///
    /// - Returns: Updated object.
    @discardableResult
    func circleBorderStyle() -> Self {
        clipsToBounds = true
        layer.cornerRadius = bounds.height / 2.0
        return self
    }
    
    /// Draws a border.
    ///
    /// - Parameters:
    ///   - width: Border line width.
    ///   - color: Border color.
    /// - Returns: Updated object.
    @discardableResult
    func borderedStyle(width: CGFloat, color: UIColor?) -> Self {
        layer.borderWidth = width
        return self.borderedStyle(color: color)
    }
    
    /// Draws a border.
    ///
    /// - Parameters:
    ///   - color: Border color.
    /// - Returns: Updated object.
    @discardableResult
    func borderedStyle(color: UIColor?) -> Self {
        layer.borderColor = color?.cgColor
        return self
    }
    
    /// Sets background color
    ///
    /// - Parameters:
    ///   - color: Background color.
    /// - Returns: Updated object.
    @discardableResult
    func backgroundColorStyle(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

}

extension UIView {
    
    /// View styles, defined by app styleguide.
    enum ViewStyle {
        case containerFilled
    }

    /// Calls all required functions to apply a specific style to a view.
    ///
    /// - Parameters:
    ///   - style: Style to be applied.
    @discardableResult
    func applyStyle(_ style: ViewStyle) -> Self {
        switch style {
        case .containerFilled:
            return self
                .backgroundColorStyle(UIColor.lightGray)
                .roundedCornersStyle()
        }
    }
}
