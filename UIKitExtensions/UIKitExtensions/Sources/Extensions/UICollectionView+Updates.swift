//
//  UICollectionView+Updates.swift
//  UIKitExtensions
//
//  Created by Igor Kulik on 10.10.2020.
//

import Foundation
import UIKit

// MARK: - Utility extension that represents collecion view updates as values and simplifies work with them.
extension UICollectionView {

    enum UpdateType {
        case insertSections(sections: IndexSet)
        case deleteSections(sections: IndexSet)
        case reloadSections(sections: IndexSet)
        case moveSection(at: Int, to: Int)
        case insertItems(indexPaths: [IndexPath])
        case deleteItems(indexPaths: [IndexPath])
        case reloadItems(indexPaths: [IndexPath])
        case moveItem(at: IndexPath, to: IndexPath)
    }
    
    final func performUpdates(_ updates: [UpdateType], completion: ((Bool) -> Void)? = nil) {
        guard !updates.isEmpty else { return }
        performBatchUpdates({
            updates.forEach({ [weak self] updateType in
                self?.performUpdate(updateType)
            })
        }, completion: { finished in
            completion?(finished)
        })
    }
    
    final private func performUpdate(_ update: UpdateType) {
        switch update {
        case let .insertSections(sections):
            insertSections(sections)
        case let .deleteSections(sections):
            deleteSections(sections)
        case let .reloadSections(sections):
            reloadSections(sections)
        case let .moveSection(atIndex, toIndex):
            moveSection(atIndex, toSection: toIndex)
        case let .insertItems(indexPaths):
            insertItems(at: indexPaths)
        case let .deleteItems(indexPaths):
            deleteItems(at: indexPaths)
        case let .reloadItems(indexPaths):
            reloadItems(at: indexPaths)
        case let .moveItem(atIndexPath, toIndexPath):
            moveItem(at: atIndexPath, to: toIndexPath)
        }
    }
}
