//
//  StandardLayoutsSectionBackgroundDecorationView.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import UIKit

class StandardLayoutsSectionBackgroundDecorationView: UICollectionReusableView {
    static let elementKind = "background-element-kind"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 233 / 255, green: 210 / 255, blue: 199 / 255, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
