//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var mailListCollectionView: UICollectionView!
    
    //constraint to shift the list to right side while in editing mode
    private var collectionViewLeadingConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        view.backgroundColor = .systemBackground
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
        
        if editing {
            // Enable multi-selection, show checkboxes, etc.
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEditing))
            
            //shift the list to right
            collectionViewLeadingConstraint?.constant = 50
            
            // Show the checkboxes in each cell
                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
                            cell.roundCheckbox.isHidden = false
                        }
                    }
            mailListCollectionView.allowsMultipleSelection = true
        } else {
            // Disable multi-selection, hide checkboxes, etc.
            navigationItem.rightBarButtonItem = editButtonItem
            
            //bring the list back to original position
            collectionViewLeadingConstraint?.constant = 0
            
            // Hide the checkboxes in each cell
                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
                            cell.roundCheckbox.isHidden = true
                        }
                    }
        }
        
        // You may need to call layoutIfNeeded to apply the constraint changes
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
    }
    @objc func cancelEditing() {
        // Implement any logic needed when the user cancels the editing mode.
        // For example, deselect any selected cells, hide checkboxes, etc.
        
        setEditing(false, animated: true)
        mailListCollectionView.allowsSelection = false
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

        collectionViewLeadingConstraint = mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            collectionViewLeadingConstraint?.isActive = true
        
        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    mailListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                    mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    mailListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        
        mailListCollectionView.register(MailListCell.self, forCellWithReuseIdentifier: "CustomCell")
        mailListCollectionView.reloadData()
        mailListCollectionView.allowsSelection = false
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
