//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

struct Item: Hashable {
   var title: String
   var subtitle: String
   var image: UIImage
}

enum Section {
    case main
    case second
}
class ViewController: UIViewController, UICollectionViewDelegate {
     var collectionView: UICollectionView!
     var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
//        setupMailListCollectionView()
        configureCollectionView()
        configureDataSource()
        applyInitialData()
    }
    
    lazy var mainSectionItems = (1...10).map { index -> Item in
        return Item(title: "Item \(index)",
                    subtitle: "First section",
                    image: UIImage(named: "unicorn")!)
    }

    lazy var secondSectionItems = (1...10).map { index -> Item in
        return Item(title: "Element \(index)",
                    subtitle: "Second section",
                    image: UIImage(named: "unicorn")!)
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: self.configureLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        let cellRegistration =
          UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
              (cell, indexPath, item) in
                var content = cell.defaultContentConfiguration()
                content.text = item.title
                content.textProperties.color = UIColor.blue
                content.secondaryText = item.subtitle
                content.image = item.image
                cell.contentConfiguration = content
        }
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView,
           cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
              return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: item)
        })
    }
    
    private func applyInitialData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main, .second])
        snapshot.appendItems(mainSectionItems, toSection: .main)
        snapshot.appendItems(secondSectionItems, toSection: .second)
        datasource.apply(snapshot, animatingDifferences: false)
    }
}

//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func setupMailListCollectionView() {
//        mailListCollectionView.backgroundColor = .white
//        mailListCollectionView.dataSource = self
//        mailListCollectionView.delegate = self
//        mailListCollectionView.register(MailListCell.self, forCellWithReuseIdentifier: "CellIdentifier")
//
//        view.addSubview(mailListCollectionView)
//        
//        // Set constraints to pin the collection view to the edges of the view controller's view
//        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            mailListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            mailListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = mailListCollectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! MailListCell
//        
//        cell.dateLabel.text = "dd/mm/yyyy"
//        cell.senderLabel.text = "some sender"
//        cell.subjectLabel.text = "some subject"
//        return cell
//    }
//}
