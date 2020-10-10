//
//  NSLayoutConstraint+RelativeLayout.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 10.10.2020.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
        
    // MARK: - Public methods
    
    /// Updates `NSLayoutContsraint.constant` property relative to the specified `constant` value.
    /// - Parameters:
    ///   - constant: Base value.
    ///   - axis: Geometrical axis which `baseDimension` relates to (either horizontal or vertical).
    ///   - relation: Relation between the base and resulting values (see `DimensionRelation`).
    func updateWithRelativeConstant(_ constant: CGFloat, for axis: Axis, relation: LayoutUtility.DimensionRelation) {
        self.constant = LayoutUtility.main.getRelativeDimension(for: constant, axis: axis, relation: relation)
    }
    
    /// Updates `NSLayoutContsraint.constant` property relative to it's current value.
    /// - Parameters:
    ///   - axis: Geometrical axis which `baseDimension` relates to (either horizontal or vertical).
    ///   - relation: Relation between the base and resulting values (see `DimensionRelation`).
    ///
    /// This method may be useful when setting constraints from storyboard. For example, when you need a specific constraint's `constant`  to be recalculated
    /// proportionally for other screen sizes without specifying any values in code, just using the value specified in storyboard,
    func updateWithRelativeCurrentConstant(for axis: Axis, relation: LayoutUtility.DimensionRelation) {
        updateWithRelativeConstant(self.constant, for: axis, relation: relation)
    }
}
