//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var mailListCollectionView: UICollectionView!
    var checkboxCollectionView: UICollectionView!
    
    var isEditingMode = false
    
    var checkboxCollectionViewLeadingConstraint: NSLayoutConstraint?
    var mailListCollectionViewLeadingConstraint: NSLayoutConstraint?
    
    //constraint to shift the list to right side while in editing mode
//    private var collectionViewLeadingConstraint: NSLayoutConstraint?
    
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
        configureCheckboxCollectionView()
        
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
            isEditingMode = true
            // Enable multi-selection, show checkboxes, etc.
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEditing))
            
            //shift the list to right
//            collectionViewLeadingConstraint?.constant = 50
            
            // Show the checkboxes and move labels to right
                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
//                            cell.moveLabelsToRight()
//                            cell.roundCheckbox.isHidden = false
//                            cell.animateCheckboxAppearance()
                            checkboxCollectionViewLeadingConstraint?.constant = 0
                            mailListCollectionViewLeadingConstraint?.constant = 50
                        }
                    }
            mailListCollectionView.allowsMultipleSelection = true
        } else {
            isEditingMode = false
            // Disable multi-selection, hide checkboxes, etc.
            navigationItem.rightBarButtonItem = editButtonItem
            
            //bring the list back to original position
//            collectionViewLeadingConstraint?.constant = 0
            
                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
//                            cell.moveLabelsToOriginalPosition()
//                            cell.roundCheckbox.isHidden = true
                            checkboxCollectionViewLeadingConstraint?.constant = -20
                            mailListCollectionViewLeadingConstraint?.constant = 0
                        }
                    }
        }
        
        // need to call layoutIfNeeded to apply the constraint changes
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
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
                config.showsSeparators = false
                return UICollectionViewCompositionalLayout.list(using: config)
    }

    func configureMailListCollectionView() {
        mailListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        mailListCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mailListCollectionView.delegate = self
        mailListCollectionView.dataSource = self
        view.addSubview(mailListCollectionView)

//        collectionViewLeadingConstraint = mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//            collectionViewLeadingConstraint?.isActive = true
        mailListCollectionViewLeadingConstraint = mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        mailListCollectionViewLeadingConstraint?.isActive = true
        
        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    mailListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    mailListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        
        mailListCollectionView.register(MailListCell.self, forCellWithReuseIdentifier: "CustomMailCell")
        mailListCollectionView.reloadData()
        mailListCollectionView.allowsSelection = false
    }

    func configureCheckboxCollectionView() {
        checkboxCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        checkboxCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        checkboxCollectionView.delegate = self
        checkboxCollectionView.dataSource = self
        view.addSubview(checkboxCollectionView)
        checkboxCollectionView.showsVerticalScrollIndicator = false
//        collectionViewLeadingConstraint = mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//            collectionViewLeadingConstraint?.isActive = true
        checkboxCollectionViewLeadingConstraint = checkboxCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20)
        checkboxCollectionViewLeadingConstraint?.isActive = true
        
        checkboxCollectionView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    checkboxCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    checkboxCollectionView.trailingAnchor.constraint(equalTo: mailListCollectionView.leadingAnchor),
                    checkboxCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        
        checkboxCollectionView.register(CheckboxCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCheckboxCell")
        checkboxCollectionView.reloadData()
        checkboxCollectionView.allowsSelection = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mailListCollectionView {
            return 100
        } else {
            return 100
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == mailListCollectionView {
//            return CGSize(width: view.frame.width, height: 100)
//        } else {
//            return CGSize(width: view.frame.width, height: 100)
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mailListCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMailCell", for: indexPath) as! MailListCell
            
            cell.resetState()
            
            if isEditingMode {
                //                cell.moveLabelsToRight()
                //            mailListCollectionView.reloadData()
                checkboxCollectionViewLeadingConstraint?.constant = 0
                mailListCollectionViewLeadingConstraint?.constant = 50
            } else {
                //                cell.moveLabelsToOriginalPosition()
                //                mailListCollectionView.reloadData()
                checkboxCollectionViewLeadingConstraint?.constant = -20
                mailListCollectionViewLeadingConstraint?.constant = 0
            }
            
            cell.senderLabel.text = "some sender"
            cell.subjectLabel.text = "some subject"
            cell.mailContentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            cell.timeLabel.text = "hh:mm"
            cell.arrowLabel.text = ">"
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCheckboxCell", for: indexPath) as! CheckboxCollectionViewCell
            
            return cell
        }
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
