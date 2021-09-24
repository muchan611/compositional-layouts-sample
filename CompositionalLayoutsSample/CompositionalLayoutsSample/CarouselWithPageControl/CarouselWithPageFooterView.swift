//
//  CarouselWithPageFooterView.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/25.
//

import UIKit

class CarouselWithPageFooterView: UICollectionReusableView {
    static let height: CGFloat = 30.0
    private let pageControl = UIPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pageControl)
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .cyan
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.topAnchor.constraint(equalTo: topAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(currentPage: Int, numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
    }
}
