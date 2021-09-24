//
//  StandardLayoutsViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import Foundation
import UIKit

class StandardLayoutsViewController: UIViewController {
    enum Section: String {
        case list
        case grid
        case carousel
        case groupPageing
        case background
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    private var collectionView: UICollectionView! = nil
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "StandardLayoutsViewController"
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.register(cellType: StandardLayoutsCollectionViewCell.self)
        collectionView.register(type: StandardLayoutsSectionHeaderView.self, kind: StandardLayoutsSectionHeaderView.elementKind)
        
        configureDataSource()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let section = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            let sectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10)
            let itemMargin: CGFloat = 6.0
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .estimated(44))
            switch section {
            case .list:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = sectionInsets
                section.interGroupSpacing = itemMargin
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: StandardLayoutsSectionHeaderView.elementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .grid:
                let width = (environment.container.contentSize.width - itemMargin) / 3
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                group.interItemSpacing = .fixed(itemMargin)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = itemMargin
                section.contentInsets = sectionInsets
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: StandardLayoutsSectionHeaderView.elementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .carousel:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(120))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = itemMargin
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = sectionInsets
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: StandardLayoutsSectionHeaderView.elementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .groupPageing:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(120))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = itemMargin
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = sectionInsets
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: StandardLayoutsSectionHeaderView.elementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .background:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = sectionInsets
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: StandardLayoutsSectionHeaderView.elementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                let sectionBackground = NSCollectionLayoutDecorationItem.background(
                        elementKind: StandardLayoutsSectionBackgroundDecorationView.elementKind)
                section.decorationItems = [sectionBackground]
                return section
            }
        }
        layout.register(StandardLayoutsSectionBackgroundDecorationView.self, forDecorationViewOfKind: StandardLayoutsSectionBackgroundDecorationView.elementKind)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(with: StandardLayoutsCollectionViewCell.self, for: indexPath)
            cell.configure(with: identifier)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == StandardLayoutsSectionHeaderView.elementKind {
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: StandardLayoutsSectionHeaderView.elementKind, with: StandardLayoutsSectionHeaderView.self, for: indexPath)
                header.configure(title: section.rawValue)
                return header
            } else {
                return nil
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        let listItems = (0...2).map { Int($0) }
        snapshot.appendSections([.list])
        snapshot.appendItems(listItems)
        let gridItems = (3...8).map { Int($0) }
        snapshot.appendSections([.grid])
        snapshot.appendItems(gridItems)
        let carouselItems = (9...15).map { Int($0) }
        snapshot.appendSections([.carousel])
        snapshot.appendItems(carouselItems)
        let groupPageingItems = (16...20).map { Int($0) }
        snapshot.appendSections([.groupPageing])
        snapshot.appendItems(groupPageingItems)
        snapshot.appendSections([.background])
        snapshot.appendItems([21])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
