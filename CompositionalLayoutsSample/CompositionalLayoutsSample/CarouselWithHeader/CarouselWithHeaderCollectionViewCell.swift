//
//  CarouselWithHeaderCollectionViewCell.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import Foundation
import UIKit

class CarouselWithHeaderCollectionViewCell: UICollectionViewCell {
    static let width: CGFloat = 100
    static let height: CGFloat = 120
    
    private let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4.0
        contentView.backgroundColor = UIColor(red: 206/255, green: 201/255, blue: 220/255, alpha: 1.0)
        
        titleLabel.textColor = .brown
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: CarouselWithHeaderListViewController.Item) {
        if case .carouselWithHeader(let sectionIndex, let itemIndex) = item {
            titleLabel.text = "\(sectionIndex), \(itemIndex)"
        }
    }
}
