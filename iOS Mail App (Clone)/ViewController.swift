//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var mailListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        
//        // Create a navigation controller with your view controller as the root view controller
        let navigationController = UINavigationController(rootViewController: self)

        // Configure the edit button
        navigationItem.rightBarButtonItem = editButtonItem
//
        configureMailListCollectionView()
        
        // Set the navigation bar background color to systemBackground
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        // Present the navigation controller
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = navigationController
            }
    }
//    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        mailListCollectionView.allowsMultipleSelection = editing
        
        if editing {
            // Enable multi-selection, show checkboxes, etc.
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEditing))
            
            // Show the checkboxes in each cell
                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
                            cell.roundCheckbox.isHidden = false
                        }
                    }
        } else {
            // Disable multi-selection, hide checkboxes, etc.
            navigationItem.rightBarButtonItem = editButtonItem
            
            // Hide the checkboxes in each cell
                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
                            cell.roundCheckbox.isHidden = true
                        }
                    }
        }
    }
    @objc func cancelEditing() {
        // Implement any logic needed when the user cancels the editing mode.
        // For example, deselect any selected cells, hide checkboxes, etc.
        
        setEditing(false, animated: true)
    }
}
    
//MARK: Configure collection view
extension ViewController {
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    func configureMailListCollectionView() {
        mailListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        mailListCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mailListCollectionView.delegate = self
        mailListCollectionView.dataSource = self
        view.addSubview(mailListCollectionView)

        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    mailListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    mailListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        
        mailListCollectionView.register(MailListCell.self, forCellWithReuseIdentifier: "CustomCell")
        mailListCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! MailListCell

        cell.senderLabel.text = "some sender"
        cell.subjectLabel.text = "some subject"
        cell.dateLabel.text = "dd/mm/yyyy"

        return cell
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
