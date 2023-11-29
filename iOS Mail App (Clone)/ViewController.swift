//
//  ViewController.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    let topView = UIView()
    var mailListCollectionView: UICollectionView!
    var editButton : UIButton!
    
    var isEditingMode = false
    
    var panGesture: UIPanGestureRecognizer?
    var selectedIndexPaths = Set<IndexPath>()
    var tapSelectedRows = Set<IndexPath>()
    var displayLink: CADisplayLink?
    var isAutoScrolling = false
    
    var initialPosition : CGFloat = 0.0
    var isDesectingFirst = false
    var initialIndexPath : IndexPath?
    var isFingerInMovement = false
    var isPanActive = false
    var initialDirection = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTopView()
        configureMailListCollectionView()
        configureEditButton()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture?.delegate = self
    }
}

//MARK: configure UI elements
extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func configureTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        //        topView.backgroundColor = .red
        view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
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
        
        mailListCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        mailListCollectionView.register(MailListCell.self, forCellWithReuseIdentifier: "cell")
        mailListCollectionView.allowsMultipleSelection = true
        
        mailListCollectionView.dataSource = self
        mailListCollectionView.delegate = self
        
        view.addSubview(mailListCollectionView)
        mailListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mailListCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        mailListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -60).isActive = true
        mailListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mailListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureEditButton() {
        editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.systemBlue, for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 18)
        editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        //        editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        //        editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MailListCell
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isEditingMode {
            print("tapped for selection")
            updateCellSelection(at: indexPath, isSelected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditingMode {
            print("tapped for deselction")
            updateCellSelection(at: indexPath, isSelected: false)
        }
    }
    
    func updateCellSelection(at indexPath: IndexPath, isSelected: Bool) {
        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
            let tickmark = UIImage(systemName: "checkmark.circle.fill")
            cell.checkbox.image = isSelected ? tickmark : nil
            cell.checkbox.layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.systemGray.cgColor
            cell.contentView.backgroundColor = isSelected ?  UIColor.placeholderText : UIColor.clear
        }
        if isSelected {
                    selectedIndexPaths.insert(indexPath)
            print(selectedIndexPaths)
                } else {
                    selectedIndexPaths.remove(indexPath)
                    print(selectedIndexPaths)
                }
    }
}

extension ViewController {
    @objc func handleEditButton() {
        if isEditingMode {
            editButton.setTitle("Edit", for: .normal)
            
            // Remove the pan gesture recognizer
            mailListCollectionView.removeGestureRecognizer(panGesture!)
            
            UIView.animate(withDuration: 0.36) {
                self.mailListCollectionView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.mailListCollectionView.scrollIndicatorInsets = .zero
            }
            isEditingMode = false
            
            // Clear selections
            clearAllSelections()
        } else {
            editButton.setTitle("Cancel", for: .normal)
            
            // Add the pan gesture recognizer
            mailListCollectionView.addGestureRecognizer(panGesture!)
            
            UIView.animate(withDuration: 0.36) {
                self.mailListCollectionView.transform = CGAffineTransform(translationX: 35, y: 0)
                let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 35)
                self.mailListCollectionView.scrollIndicatorInsets = inset
            }
            isEditingMode = true
        }
    }
    
    func clearAllSelections() {
        // Clear selections using the data structure
        selectedIndexPaths.forEach { indexPath in
            mailListCollectionView.deselectItem(at: indexPath, animated: false)
            updateCellSelection(at: indexPath, isSelected: false)
        }
        selectedIndexPaths.removeAll()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            // Check if the pan gesture is within the left 100 points
            let touchPoint = panGesture?.location(in: view)
            if touchPoint?.x ?? 0 < 100 {
                return false
            }
            return true
        }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let location = gestureRecognizer.location(in: mailListCollectionView)
        
        switch gestureRecognizer.state {
        case .began:
            
            initialPosition = location.y
            if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
                if selectedIndexPaths.contains(indexPath) {
                    isDesectingFirst = true
                    handleDeSelection(at: indexPath, isSelected: false)
                }
                else {
                    handleCellSelection(at: indexPath, isSelected: true)
                }
                initialIndexPath = indexPath
            }
            
        case .changed:
            let velocity = gestureRecognizer.velocity(in: mailListCollectionView)
            let currentDirection = getDirection(velocity)
            isFingerInMovement = true
            
            if isPanActive == false {
                isPanActive = true
                initialDirection = getDirection(velocity)
            }
            // new pan on already selected
            if isDesectingFirst {
                if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
                    if tapSelectedRows.contains(indexPath) {
                        tapSelectedRows.remove(indexPath)
                    }
                    handleDeSelection(at: indexPath, isSelected: false)
                }
            }
            
            else {
                
                if initialDirection == "Down" {
                    if currentDirection == "Down" {
                        if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
                            handleCellSelection(at: indexPath, isSelected: true)
                        }
                    }
                    else {
                        if location.y < initialPosition {
                            initialDirection = "Up"
                        }
                        else {
                            if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
                                if indexPath != initialIndexPath {
                                    if !tapSelectedRows.contains(indexPath) {
                                        handleDeSelection(at: indexPath, isSelected: false)
                                    }
                                }
                            }
                        }
                    }
                }
                else if initialDirection == "Up" {
                    if currentDirection == "Up" {
                        if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
                            handleCellSelection(at: indexPath, isSelected: true)
                        }
                    } else {
                        if location.y > initialPosition {
                            initialDirection = "Down"
                        }
                        if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
                            if indexPath != initialIndexPath {
                                if !tapSelectedRows.contains(indexPath) {
                                    handleDeSelection(at: indexPath, isSelected: false)
                                }
                            }
                        }
                    }
                }
            }
        default:
            isDesectingFirst = false
            isPanActive = false
            isFingerInMovement = false
            break
        }
    }
    
    func handleDeSelection(at indexPath: IndexPath, isSelected: Bool) {
        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
            let tickmark = UIImage(systemName: "checkmark.circle.fill")
            cell.checkbox.image = isSelected ? tickmark : nil
            cell.checkbox.layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.systemGray.cgColor
            cell.contentView.backgroundColor = isSelected ?  UIColor.placeholderText : UIColor.clear
        }
        if selectedIndexPaths.contains(indexPath) {
            selectedIndexPaths.remove(indexPath)
            mailListCollectionView.deselectItem(at: indexPath, animated: false)
        }
    }
    
    func handleCellSelection(at indexPath: IndexPath, isSelected: Bool) {
        if let cell = mailListCollectionView.cellForItem(at: indexPath) as? MailListCell {
            let tickmark = UIImage(systemName: "checkmark.circle.fill")
            cell.checkbox.image = isSelected ? tickmark : nil
            cell.checkbox.layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.systemGray.cgColor
            cell.contentView.backgroundColor = isSelected ?  UIColor.placeholderText : UIColor.clear
        }
        if !selectedIndexPaths.contains(indexPath) {
            selectedIndexPaths.insert(indexPath)
            mailListCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
    }
    
    func getDirection(_ velocity: CGPoint) -> String {
        let direction = velocity.y > 0 ? "Down" : "Up"
        return direction
    }
}
