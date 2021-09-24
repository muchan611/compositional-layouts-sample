//
//  CarouselWithHeaderSectionHeaderView.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import UIKit

class CarouselWithHeaderSectionHeaderView: UICollectionReusableView {
    static let height: CGFloat = 60
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let horizontalStackView = UIStackView()
        addSubview(horizontalStackView)
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 6
        horizontalStackView.alignment = .center
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let titleStackView = UIStackView()
        horizontalStackView.addArrangedSubview(titleStackView)
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.spacing = 2

        titleStackView.addArrangedSubview(titleLabel)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = .darkGray
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleStackView.addArrangedSubview(subTitleLabel)
        subTitleLabel.adjustsFontForContentSizeCategory = true
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        subTitleLabel.textColor = .darkGray
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let arrowIconView = UIImageView()
        horizontalStackView.addArrangedSubview(arrowIconView)
        arrowIconView.image = UIImage(systemName: "chevron.right")
        arrowIconView.tintColor = .darkGray
        arrowIconView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16)
        arrowIconView.contentMode = .scaleAspectFit
        arrowIconView.translatesAutoresizingMaskIntoConstraints = false
        arrowIconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
