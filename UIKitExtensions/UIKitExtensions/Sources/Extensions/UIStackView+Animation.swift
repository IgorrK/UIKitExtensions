//
//  UIStackView+Animation.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 10.10.2020.
//

import Foundation
import UIKit

extension UIStackView {
    
    /// Animates visibility change of the specified view which is arranged in UIStackView instance.
    ///
    /// - Parameters:
    ///   - subview: View to be shown/hidden.
    ///   - duration: Animation duration.
    ///   - hidden: Defines whether the view should be hidden or shown.
    ///   - completion: Operation callback.
    func animateSubviewHiding(_ subview: UIView,
                              isHidden: Bool,
                              duration: TimeInterval = AnimationConstants.defaultDuration,
                              completion: Callback<Bool>? = nil) {
        guard arrangedSubviews.contains(subview),
            subview.isHidden != isHidden else {
                return
        }
        
        UIView.animate(withDuration: duration,
                       animations: { [weak self] in
                        subview.isHidden = isHidden
                        self?.layoutIfNeeded()
            }, completion: completion)
    }
}
