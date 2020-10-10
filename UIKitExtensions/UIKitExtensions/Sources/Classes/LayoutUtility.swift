//
//  LayoutUtility.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 10.10.2020.
//

import Foundation
import UIKit

final class LayoutUtility {
    
    // MARK: - Default screen dimensions, specified in design (for instance, iPhone 6)
    
    private static var designScreenBounds: CGSize { CGSize(width: 335.0, height: 667.0) }
    
    // MARK: - Properties
    
    static let main = LayoutUtility(with: UIScreen.main)
    private let screenBounds: CGRect
    
    /// i.e. actual screen width, divided by the width in design.
    private var relativeWidthMultiplier: CGFloat {
        return screenBounds.width / Self.designScreenBounds.width
    }
    
    /// i.e. actual screen height, divided by the height in design.
    private var relativeHeightMultiplier: CGFloat {
        return screenBounds.height / Self.designScreenBounds.height
    }

    // MARK: - Lifecycle
    
    init(with screen: UIScreen) {
        self.screenBounds = screen.bounds
    }
        
    // MARK: - Public methods
    
    /// Calculates relative dimension value for `baseDimension`, considering `axis` and `relation` limitation
    /// - Parameters:
    ///   - baseDimension: Basic dimension value.
    ///   - axis: Geometrical axis which `baseDimension` relates to (either horizontal or vertical).
    ///   - relation: Relation between the base and resulting values (see `DimensionRelation`).
    /// - Returns: Relative dimension value.
    func getRelativeDimension(for baseDimension: CGFloat,
                              axis: NSLayoutConstraint.Axis,
                              relation: DimensionRelation) -> CGFloat {
        let multiplier: CGFloat
        switch axis {
        case .horizontal:
            multiplier = relativeWidthMultiplier
        case .vertical:
            multiplier = relativeHeightMultiplier
        @unknown default:
            multiplier = 1.0
        }
        
        let relativeDimension = baseDimension * multiplier

        switch relation {
        case .lessThanOrEqual:
            return min(baseDimension, relativeDimension)
        case .proportional:
            return relativeDimension
        case .greaterThanOrEqual:
            return max(baseDimension, relativeDimension)
        }
    }
}

// MARK: - Nested types
extension LayoutUtility {
    
    /// Defines how a particular dimension should be recalculated for the current screen.
    /// - lessThanOrEqual: dimension can be recalculated for a screen smaller than in design, but kept the same for larger screens.
    /// - proportional: dimension can be recalculated for a screens both smaller and larger than in design.
    /// - greaterThanOrEqual: dimension can be recalculated for a screen larger than in design, but kept the same for smaller screens.
    enum DimensionRelation {
        case lessThanOrEqual
        case proportional
        case greaterThanOrEqual
    }
}
