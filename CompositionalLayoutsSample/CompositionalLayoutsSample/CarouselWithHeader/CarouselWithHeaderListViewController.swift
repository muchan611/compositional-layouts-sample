//
//  CarouselWithHeaderListViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/24.
//

import Foundation
import UIKit

class CarouselWithHeaderListViewController: UIViewController {
    enum Section: Hashable {
        case carouselWithHeader(sectionIndex: Int)
    }
    enum Item: Hashable {
        case carouselWithHeader(sectionIndex: Int, itemIndex: Int)
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    private var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CarouselWithHeaderViewController"
        
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
        collectionView.register(CarouselWithHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "CarouselWithHeaderCollectionViewCell")
        collectionView.register(CarouselWithHeaderSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CarouselWithHeaderSectionHeaderView")
        
        configureDataSource()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(CarouselWithHeaderCollectionViewCell.width),
            heightDimension: .absolute(CarouselWithHeaderCollectionViewCell.height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8.0
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(CarouselWithHeaderSectionHeaderView.height))
        section.boundarySupplementaryItems = [
            .init(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselWithHeaderCollectionViewCell", for: indexPath) as? CarouselWithHeaderCollectionViewCell else {
                fatalError("Could not dequeue a cell.")
            }
            cell.configure(with: identifier)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CarouselWithHeaderSectionHeaderView", for: indexPath) as? CarouselWithHeaderSectionHeaderView else {
                    fatalError("Could not dequeue a view.")
                }
                if case .carouselWithHeader(sectionIndex: let sectionIndex) = section {
                    header.configure(title: "Section: \(sectionIndex)", subTitle: "サブタイトル")
                }
                return header
            } else {
                return nil
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        for i in (0...5) {
            let items: [Item] = (0...10).map { .carouselWithHeader(sectionIndex: i, itemIndex: $0) }
            snapshot.appendSections([.carouselWithHeader(sectionIndex: i)])
            snapshot.appendItems(items)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

