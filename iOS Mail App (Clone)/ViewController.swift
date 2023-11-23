//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedIndexPaths: Set<IndexPath> = []
    
    var mailListCollectionView: UICollectionView!
    var editButton : UIButton!
    
    var isEditingMode = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        mailListCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        mailListCollectionView.register(NotesCell.self, forCellWithReuseIdentifier: "cell")
        mailListCollectionView.allowsMultipleSelection = true
        
        mailListCollectionView.dataSource = self
        mailListCollectionView.delegate = self
        
        view.addSubview(mailListCollectionView)
        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mailListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -60).isActive = true
        mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mailListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.systemBlue, for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 20)
        editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 280).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    }
    
    var pan : UIPanGestureRecognizer!
    var initialIndexPath: IndexPath?
    
    enum PanDirection {
        case up, down
    }

    var lastDirection: PanDirection = .down // Variable to track the last detected direction

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: mailListCollectionView)
        
        switch gesture.state {
        case .began:
            if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
                initialIndexPath = indexPath
                selectedIndexPaths.insert(indexPath)
                updateCellSelection(at: indexPath, isSelected: true)
            }
        case .changed:
            if let initialIndexPath = initialIndexPath {
                if let indexPath = mailListCollectionView.indexPathForItem(at: location), indexPath != initialIndexPath {
                    let currentDirection = calculateDirection(of: gesture)
                    
                    if currentDirection == .down {
                        deselectCells(from: indexPath, to: initialIndexPath)
                    } else {
                        deselectCells(from: initialIndexPath, to: indexPath)
                    }
                }
            }
        case .ended, .cancelled:
            initialIndexPath = nil
        default:
            break
        }
    }

    func calculateDirection(of gesture: UIPanGestureRecognizer) -> PanDirection {
        let velocity = gesture.velocity(in: mailListCollectionView)
        return velocity.y < 0 ? .up : .down
    }

    func deselectCells(from startIndexPath: IndexPath, to endIndexPath: IndexPath) {
        let indicesToDeselect = (min(startIndexPath.row, endIndexPath.row)...max(startIndexPath.row, endIndexPath.row))
            .map { IndexPath(row: $0, section: startIndexPath.section) }
        
        for indexPath in indicesToDeselect {
            if !selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.insert(indexPath)
                updateCellSelection(at: indexPath, isSelected: true)
            }
        }
        
        let indicesToKeepSelected = (mailListCollectionView.indexPathsForVisibleItems).filter { !indicesToDeselect.contains($0) }
        for indexPath in indicesToKeepSelected {
            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.remove(indexPath)
                updateCellSelection(at: indexPath, isSelected: false)
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NotesCell
        cell.backgroundColor = .systemGray5
        cell.circle.backgroundColor = .white
        cell.circleView.backgroundColor = .systemGray4
        
        cell.senderLabel.text = "some sender"
        cell.subjectLabel.text = "some subject"
        cell.mailContentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        cell.timeLabel.text = "hh:mm"
        cell.arrowLabel.text = ">"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width + 60, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    @objc func handleEditButton() {
        if isEditingMode {
            editButton.setTitle("Edit", for: .normal)
            UIView.animate(withDuration: 0.36) {
                self.mailListCollectionView.transform = .identity
            }
            isEditingMode = false

            // Remove pan gesture from all cells
            for cell in mailListCollectionView.visibleCells {
                if let notesCell = cell as? NotesCell {
                    notesCell.circle.removeGestureRecognizer(pan)
                }
            }
        } else {
            editButton.setTitle("Cancel", for: .normal)
            UIView.animate(withDuration: 0.36) {
                self.mailListCollectionView.transform = CGAffineTransform(translationX: 60, y: 0)
            }
            isEditingMode = true

            // Add pan gesture to all cells
            for cell in mailListCollectionView.visibleCells {
                if let notesCell = cell as? NotesCell {
                    notesCell.circle.addGestureRecognizer(pan)
                }
            }
        }
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
        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? NotesCell {
            let tickmark = UIImage(systemName: "checkmark.circle.fill")
            cell.circle.image = isSelected ? tickmark : nil
        }
    }
}
