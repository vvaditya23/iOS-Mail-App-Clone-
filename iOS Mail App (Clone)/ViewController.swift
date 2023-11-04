//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class ViewController: UIViewController {
    let mailListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        setupMailListCollectionView()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupMailListCollectionView() {
        mailListCollectionView.backgroundColor = .white
        mailListCollectionView.dataSource = self
        mailListCollectionView.delegate = self
        mailListCollectionView.register(MailListCell.self, forCellWithReuseIdentifier: "CellIdentifier")

        view.addSubview(mailListCollectionView)
        
        // Set constraints to pin the collection view to the edges of the view controller's view
        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mailListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mailListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mailListCollectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! MailListCell
        
        cell.dateLabel.text = "dd/mm/yyyy"
        cell.senderLabel.text = "some sender"
        cell.subjectLabel.text = "some subject"
        return cell
    }
}
