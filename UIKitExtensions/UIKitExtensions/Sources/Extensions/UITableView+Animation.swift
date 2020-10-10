//
//  UITableView+Animation.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 10.10.2020.
//

import Foundation
import UIKit

extension UITableView {
    /// Reloads table with 'cross dissolve' animation.
    /// Can be used instead of `beginUpdates() / endUpdates()`,
    /// if you need just basic animation.
    func reloadDataAnimated() {
        self.animateTransition(animations: { [weak self] in
            self?.reloadData()
        })
    }
}
