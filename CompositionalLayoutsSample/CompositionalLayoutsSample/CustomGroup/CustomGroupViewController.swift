//
//  CustomGroupViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import Foundation
import UIKit

class CustomGroupViewController: UIViewController {
    enum Section: Hashable {
        case main
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    private var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CustomGroupViewController"
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.register(cellType: CustomGroupCollectionViewCell.self)
        
        configureDataSource()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let sideHorizontalMargin: CGFloat = 16
            let midHorizontalMargin: CGFloat = 12
            let midVerticalMargin: CGFloat = 12

            let cellWidth = (environment.container.contentSize.width - sideHorizontalMargin * 2 - midHorizontalMargin) / 2

            let shorterCellHeight = cellWidth
            let tallerCellHeight = shorterCellHeight * 1.2
            let groupHeight = shorterCellHeight + midVerticalMargin + tallerCellHeight + midVerticalMargin

            // 4アイテムで構成されたグループ
            let group = NSCollectionLayoutGroup.custom(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(groupHeight))) { environment in
                let insets = environment.container.effectiveContentInsets

                let frame1 = CGRect(x: insets.leading, y: insets.top, width: cellWidth, height: shorterCellHeight)
                let frame2 = CGRect(x: frame1.maxX + midHorizontalMargin, y: insets.top, width: cellWidth, height: tallerCellHeight)
                let frame3 = CGRect(x: frame1.minX, y: frame1.maxY + midVerticalMargin, width: cellWidth, height: tallerCellHeight)
                let frame4 = CGRect(x: frame1.maxX + midHorizontalMargin, y: frame2.maxY + midVerticalMargin, width: cellWidth, height: shorterCellHeight)

                return [frame1, frame2, frame3, frame4].map(NSCollectionLayoutGroupCustomItem.init(frame:))
            }
            group.contentInsets = .init(top: 13, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideHorizontalMargin, bottom: 0, trailing: sideHorizontalMargin)
            return section
        }
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(with: CustomGroupCollectionViewCell.self, for: indexPath)
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        let items = (0...10).map { Int($0) }
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

