//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var mailListCollectionView: UICollectionView!
    var isEditingMode = false
    var selectedIndexPaths: Set<IndexPath> = []
    let editButton = UIButton()
    
    let cellObj = MailListCell()
    
    //constraint to shift the list to right side while in editing mode
//    private var collectionViewLeadingConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        view.backgroundColor = .systemBackground
//        // Create a navigation controller with your view controller as the root view controller
//        let navigationController = UINavigationController(rootViewController: self)

        // Configure the edit button
//        navigationItem.rightBarButtonItem = editButtonItem
//
        configureMailListCollectionView()
        configureEditButton()
        
        // Set the navigation bar background color to systemBackground
//            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = .systemBackground
//            navigationController.navigationBar.standardAppearance = appearance
//            navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        // Present the navigation controller
//            if let window = UIApplication.shared.windows.first {
//                window.rootViewController = navigationController
//            }
    }
//
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        
//        if editing {
//            isEditingMode = true
//            // Enable multi-selection, show checkboxes, etc.
//            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEditing))
//            
//            //shift the list to right
////            collectionViewLeadingConstraint?.constant = 50
//            
//            // Show the checkboxes and move labels to right
//                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
//                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
//                            cell.moveLabelsToRight()
////                            cell.roundCheckbox.isHidden = false
////                            cell.animateCheckboxAppearance()
//                        }
//                    }
//            mailListCollectionView.allowsMultipleSelection = true
//        } else {
//            isEditingMode = false
//            // Disable multi-selection, hide checkboxes, etc.
//            navigationItem.rightBarButtonItem = editButtonItem
//            
//            //bring the list back to original position
////            collectionViewLeadingConstraint?.constant = 0
//            
//                    for indexPath in mailListCollectionView.indexPathsForVisibleItems {
//                        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
//                            cell.moveLabelsToOriginalPosition()
////                            cell.roundCheckbox.isHidden = true
//                        }
//                    }
//        }
//        
//        // need to call layoutIfNeeded to apply the constraint changes
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
//    }
    @objc func cancelEditing() {
        // Implement any logic needed when the user cancels the editing mode.
        // For example, deselect any selected cells, hide checkboxes, etc.
        
        setEditing(false, animated: true)
        mailListCollectionView.allowsSelection = false
    }
}

//MARK: configure edit button
extension ViewController {
    func configureEditButton() {
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.systemBlue, for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 17)
        editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
//        editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    @objc func handleEditButton() {
        if isEditingMode {
            editButton.setTitle("Edit", for: .normal)
            UIView.animate(withDuration: 0.36) {
                self.mailListCollectionView.visibleCells.forEach { cell in
                    if let mailCell = cell as? MailListCell {
                        mailCell.moveLabelsToOriginalPosition()
                    }
                }
            }
            selectedIndexPaths.removeAll()
            isEditingMode = false
        } else {
            editButton.setTitle("Cancel", for: .normal)
            UIView.animate(withDuration: 0.36) {
                self.mailListCollectionView.visibleCells.forEach { cell in
                    if let mailCell = cell as? MailListCell {
                        mailCell.moveLabelsToRight()
                    }
                }
            }
            isEditingMode = true
        }
    }
}

//MARK: Configure collection view
extension ViewController: UICollectionViewDelegateFlowLayout {
    private func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                return layout
    }

    func configureMailListCollectionView() {
        mailListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        mailListCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mailListCollectionView.delegate = self
        mailListCollectionView.dataSource = self
        view.addSubview(mailListCollectionView)

//        collectionViewLeadingConstraint = mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//            collectionViewLeadingConstraint?.isActive = true
        
        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    mailListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    mailListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        
        mailListCollectionView.register(MailListCell.self, forCellWithReuseIdentifier: "CustomCell")
        mailListCollectionView.reloadData()
        mailListCollectionView.allowsSelection = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! MailListCell
        
//        cell.resetState()
        
//        if isEditingMode {
////                cell.moveLabelsToRight()
////            mailListCollectionView.reloadData()
//            } else {
////                cell.moveLabelsToOriginalPosition()
////                mailListCollectionView.reloadData()
//            }
        
        cell.senderLabel.text = "some sender"
        cell.subjectLabel.text = "some subject"
        cell.mailContentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        cell.timeLabel.text = "hh:mm"
        cell.arrowLabel.text = ">"

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        if isEditingMode {
            print("Select")
            selectedIndexPaths.insert(indexPath)
            updateCellSelection(at: indexPath, isSelected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditingMode {
            print("De - Select")
            selectedIndexPaths.remove(indexPath)
            updateCellSelection(at: indexPath, isSelected: false)
        }
    }
    
    func updateCellSelection(at indexPath: IndexPath, isSelected: Bool) {
        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
            let tickmark = UIImage(systemName: "checkmark.circle.fill")
            cell.roundCheckbox.image = isSelected ? tickmark : nil
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
