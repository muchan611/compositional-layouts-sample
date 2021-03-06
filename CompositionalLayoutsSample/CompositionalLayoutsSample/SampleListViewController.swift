//
//  SampleListViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Mutsumi Kakuta on 2021/09/20.
//

import Foundation
import UIKit

class SampleListViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case standard
        case carouselWithHeader
        case customGroup
        case carouselWithPageControl
    }
    private let tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Compositional Layouts Sample"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension SampleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .standard:
            let viewController = StandardLayoutsViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case .carouselWithHeader:
            let viewController = CarouselWithHeaderListViewController()
            viewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(viewController, animated: true)
        case .customGroup:
            let viewController = CustomGroupViewController()
            viewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(viewController, animated: true)
        case .carouselWithPageControl:
            let viewController = CarouselWithPageControlViewController()
            viewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(viewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SampleListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        switch section {
        case .standard:
            cell.textLabel?.text = "StandardLayoutsViewController"
        case .carouselWithHeader:
            cell.textLabel?.text = "CarouselWithHeaderListViewController"
        case .customGroup:
            cell.textLabel?.text = "CustomGroupViewController"
        case .carouselWithPageControl:
            cell.textLabel?.text = "CarouselWithPageControlViewController"
        }
        return cell
    }
}
