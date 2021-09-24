//
//  UICollectionView+Extension.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import UIKit

extension UICollectionView {
    public func register(cellType: UICollectionViewCell.Type, useNib: Bool = false, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        if useNib {
            let nib = UINib(nibName: className, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: className)
        } else {
            register(cellType, forCellWithReuseIdentifier: className)
        }

    }

    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T
        guard let dequeueCell = cell else {
            fatalError("Could not dequeue a cell of class \(className)")
        }
        return dequeueCell
    }

    public func register(type: UICollectionReusableView.Type, kind: String, useNib: Bool = false, bundle: Bundle? = nil) {
        let className = String(describing: type)
        if useNib {
            let nib = UINib(nibName: className, bundle: bundle)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
        } else {
            register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
        }
    }

    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, with type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath) as? T
        guard let dequeueView = view else {
            fatalError("Could not dequeue a cell of class \(className)")
        }
        return dequeueView
    }
}
