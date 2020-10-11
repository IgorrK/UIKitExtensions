//
//  UIButton+Style.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 11.10.2020.
//

import Foundation
import UIKit

/// Functional-like API for style customization of `UIButton` and its subclasses.
/// This is a general approach which can be adjusted for each specific project.
extension UIButton {

    /// Button styles, defined by app styleguide.
    @objc enum ButtonStyle: Int {
        case cta = 0
        case flatCTA
        case circleCTA
        case bordered
        case circleBordered
        case option
        case like
    }
    
    /// Sets title for specified control state.
    ///
    /// - Parameters:
    ///   - title: Title text.
    ///   - state: Target control state.
    /// - Returns: Updated object.
    @discardableResult
    @objc func titleStyle(title: String?, for state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }
    
    /// Sets title color for specified control state.
    ///
    /// - Parameters:
    ///   - color: Title color.
    ///   - state: Target control state.
    /// - Returns: Updated object.
    @discardableResult
    @objc func titleColorStyle(color: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    /// Sets title color for a specified array of control states.
    ///
    /// - Parameters:
    ///   - color: Title color.
    ///   - states: Array of target control states.
    /// - Returns: Updated object.
    @discardableResult
    func titleColorStyle(color: UIColor, for states: [UIControl.State]) -> Self {
        guard !states.isEmpty else { return self }
        var remainingStates = states
        let state = remainingStates.removeLast()
        return self
            .titleColorStyle(color: color, for: state)
            .titleColorStyle(color: color, for: remainingStates)
    }
    
    /// Sets image for specified control state.
    ///
    /// - Parameters:
    ///   - image: Image to be set.
    ///   - state: Target control state.
    /// - Returns: Updated object.
    @discardableResult
    @objc func imageStyle(image: UIImage?, for state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }

    /// Sets image for specified array of control states.
    ///
    /// - Parameters:
    ///   - title: Image.
    ///   - states: Target control states.
    /// - Returns: Updated object.
    @discardableResult
    func imageStyle(image: UIImage?, for states: [UIControl.State]) -> Self {
        guard !states.isEmpty else { return self }
        var remainingStates = states
        let state = remainingStates.removeLast()
        return self
            .imageStyle(image: image, for: state)
            .imageStyle(image: image, for: remainingStates)
    }
    
    /// Sets background image for specified control state.
    ///
    /// - Parameters:
    ///   - image: Background image.
    ///   - state: Target control state.
    /// - Returns: Updated object.
    @discardableResult
    func backgroundImageStyle(image: UIImage?, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    
    /// Sets background color for specified control state.
    ///
    /// - Parameters:
    ///   - color: Background color.
    ///   - state: Target control state.
    /// - Returns: Updated object.
    @discardableResult
    func backgroundColorStyle(color: UIColor, for state: UIControl.State = .normal) -> Self {
        return backgroundImageStyle(image: color.pixelImage(), for: state)
    }
    
    /// Sets background color for a specified array of control states.
    ///
    /// - Parameters:
    ///   - color: Background color.
    ///   - states: Array of target control states.
    /// - Returns: Updated object.
    @discardableResult
    func backgroundColorStyle(color: UIColor, for states: [UIControl.State]) -> Self {
        guard !states.isEmpty else { return self }
        var remainingStates = states
        let state = remainingStates.removeLast()
        return self
            .backgroundColorStyle(color: color, for: state)
            .backgroundColorStyle(color: color, for: remainingStates)
    }
    
    /// Sets font for title label.
    ///
    /// - Parameter font: Title label font.
    /// - Returns: Updated object.
    @discardableResult
    @objc func titleFontStyle(font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    /// Sets a specified spacing amount between image and title.
    /// - Parameter spacing: Spacing between image and title.
    @discardableResult
    func contentSpacingStyle(spacing: CGFloat) -> Self {
        let insetAmount = spacing / 2.0
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -insetAmount, bottom: 0.0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: insetAmount, bottom: 0.0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0.0, left: insetAmount, bottom: 0.0, right: insetAmount)
        return self
    }
    /// Calls all required functions to apply a specific style to a button.
    ///
    /// - Parameters:
    ///   - style: Style to be applied.
    ///   - theme: Common application theme.
    // swiftlint:disable function_body_length
    @discardableResult
    @objc func applyStyle(_ style: ButtonStyle) -> Self {
        switch style {
        case .cta:
            return self
                .applyStyle(.flatCTA)
                .roundedCornersStyle()
        case .flatCTA:
            let activeColor = UIColor.green
            let disabledColor = UIColor.gray
            let highlightedColor = UIColor.systemIndigo
            adjustsImageWhenDisabled = false
            return self
                .backgroundColorStyle(color: activeColor, for: .normal)
                .backgroundColorStyle(color: disabledColor, for: .disabled)
                .backgroundColorStyle(color: highlightedColor, for: .highlighted)
                .titleFontStyle(font: UIFont.boldSystemFont(ofSize: 14.0))
                .titleColorStyle(color: .white, for: [.normal, .disabled, .highlighted])
        case .circleCTA:
            return self
                .applyStyle(.flatCTA)
                .circleBorderStyle()
        case .bordered:
            let normalTitleColor = UIColor.green
            let highlightedTitleColor = UIColor.gray
            return self
                .borderedStyle(width: 1.0, color: normalTitleColor)
                .titleColorStyle(color: normalTitleColor, for: .normal)
                .titleColorStyle(color: highlightedTitleColor, for: .highlighted)
        case .circleBordered:
            let normalBgColor = UIColor.white
            let normalTitleColor = UIColor.green
            let highlightedTitleColor = UIColor.gray
            return self
                .backgroundColorStyle(color: normalBgColor, for: .normal)
                .borderedStyle(width: 1.0, color: UIColor.green)
                .titleColorStyle(color: normalTitleColor, for: .normal)
                .titleColorStyle(color: highlightedTitleColor, for: .highlighted)
                .circleBorderStyle()
        case .option:
            let activeColor = UIColor.clear
            let disabledColor = UIColor.lightGray
            let highlightedColor = UIColor.gray
            return self
                .titleFontStyle(font: UIFont.boldSystemFont(ofSize: 14.0))
                .backgroundColorStyle(color: activeColor, for: .normal)
                .backgroundColorStyle(color: disabledColor, for: .disabled)
                .backgroundColorStyle(color: highlightedColor, for: .selected)
                .borderedStyle(width: 1.0, color: highlightedColor)
                .roundedCornersStyle()
                .titleColorStyle(color: highlightedColor, for: .normal)
                .titleColorStyle(color: .white, for: [.disabled, .selected])
        case .like:
            return self
                .imageStyle(image: UIImage(named: "heart-outline"))
                .imageStyle(image: UIImage(named: "heart-filled"), for: .selected)
        }
    }
}
