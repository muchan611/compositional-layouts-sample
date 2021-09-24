//
//  StandardLayoutsCollectionViewCell.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import UIKit

class StandardLayoutsCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4.0
        contentView.backgroundColor = UIColor(red: 206/255, green: 201/255, blue: 220/255, alpha: 1.0)
        
        titleLabel.textColor = .brown
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with index: Int) {
        titleLabel.text = "\(index)"
    }
}
