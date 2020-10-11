//
//  UIColor.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 11.10.2020.
//

import Foundation
import UIKit

extension UIColor {
    /// Generates pixel image with particular color - very convenient for tiled backgrounds.
    ///
    /// - Returns: UIImage colored with current color
    func pixelImage() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
