//
//  UIView+Utility.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 10.10.2020.
//

import Foundation
import UIKit

// Useful utilities for UIView.
extension UIView {
    
    // MARK: - Nested types
    
    struct AnimationConstants {
        static let defaultDuration: TimeInterval = 0.25
    }
    
    // MARK: - Public methods
    
    /// Blocks delivery of touch events to other views, except the view that calls the function and its subviews.
    func makeExclusiveTouchForSubviews() {
        subviews.forEach({ $0.makeExclusiveTouch() })
    }
    
    /// Blocks delivery of touch events to other views in the same window.
    private func makeExclusiveTouch() {
        if self is UIControl {
            isExclusiveTouch = true
        }
        makeExclusiveTouchForSubviews()
    }
    
    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false`,
    /// allowing to properly add constraints to views created programatically.
    /// - Returns: Configured view.
    @discardableResult
    func prepareForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    /// Animates constraint changes inside the view by calling `layoutIfNeeded` method.
    /// - Parameters:
    ///   - duration: Animation duration.
    ///   - completion: Code to run when the animation is completed.
    func animateConstraints(duration: TimeInterval = AnimationConstants.defaultDuration, completion: Callback<Bool>? = nil) {
        UIView.animate(withDuration: duration,
                       animations: { [weak self] in
                        self?.layoutIfNeeded()
                       }, completion: completion)
    }
    
    /// Applies a transition to the specified view so that you can make state changes to it.
    /// - Parameters:
    ///   - duration: Transition duration.
    ///   - options: Animation options.
    ///   - animations: Contains  view  state changes that need to be made.
    ///   - completion: Code to run when the transition is completed.
    func animateTransition(duration: TimeInterval = AnimationConstants.defaultDuration,
                           options: UIView.AnimationOptions = .transitionCrossDissolve,
                           animations: @escaping Completion,
                           completion: Callback<Bool>? = nil) {
        UIView.transition(with: self, duration: duration, options: options, animations: animations, completion: completion)
    }
    
    /// Embeds the specified view into `containerView`.
    /// - Parameters:
    ///   - containerView: A container view.
    ///   - index: Index to insert a subview at. If not specified, just adds a subview from the above of view stack.
    ///   - relativeToSafeArea: Defines if safe area insets should be also considered.
    ///   - contentInset: Optional inset between container bounds and the view to be embedded.
    func embed(in containerView: UIView,
               at index: Int? = nil,
               relativeToSafeArea: Bool = true,
               contentInset: UIEdgeInsets = .zero) {
        self.prepareForAutoLayout()
        
        // Insertion depending on the index.
        if let index = index {
            containerView.insertSubview(self, at: index)
        } else {
            containerView.addSubview(self)
        }
        
        // Constraints.
        let constraints: [NSLayoutConstraint]
        if relativeToSafeArea {
            constraints = [topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: contentInset.top),
                           containerView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: contentInset.bottom),
                           leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: contentInset.left),
                           containerView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: contentInset.right)]
        } else {
            constraints = [topAnchor.constraint(equalTo: containerView.topAnchor, constant: contentInset.top),
                           containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: contentInset.bottom),
                           leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: contentInset.left),
                           containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: contentInset.right)]
        }
        NSLayoutConstraint.activate(constraints)
    }
}
