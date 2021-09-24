//
//  CustomGroupCollectionViewCell.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import UIKit

class CustomGroupCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4.0
        contentView.backgroundColor = UIColor(red: 206/255, green: 201/255, blue: 220/255, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
