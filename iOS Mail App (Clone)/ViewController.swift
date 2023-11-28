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
    var displayLink: CADisplayLink?
    var isAutoScrolling = false
    
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
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        switch gesture.state {
        case .began, .changed:
            print("began")
            if let indexPath = mailListCollectionView.indexPathForItem(at: gesture.location(in: mailListCollectionView)) {
                // Update the selection state based on the gesture
                let isSwipingDown = translation.y < 0
                
                // Toggle the selection state based on the swipe direction
                updateCellSelection(at: indexPath, isSelected: !isSwipingDown)

                // Check if the user is swiping near the top or bottom
                let topThreshold: CGFloat = 50
                let bottomThreshold = view.bounds.maxY - 50

                if isSwipingDown && gesture.location(in: view).y > bottomThreshold {
                    // Start scrolling the collection view automatically downwards
//                    startAutoScroll()
                } else if !isSwipingDown && gesture.location(in: view).y < topThreshold {
                    // Start scrolling the collection view automatically upwards
//                    startAutoScrollUpwards()
                } else {
                    // Stop auto-scrolling if not near the top or bottom
//                    stopAutoScroll()
                }
            }

        case .ended:
            print("end")
            // Stop auto-scrolling when the gesture ends
//            stopAutoScroll()

        default:
            break
        }
    }

//        func startAutoScroll() {
//            guard !isAutoScrolling else { return }
//
//            isAutoScrolling = true
//            displayLink = CADisplayLink(target: self, selector: #selector(autoScroll))
//            displayLink?.add(to: .main, forMode: .common)
//        }
//
//        func stopAutoScroll() {
//            isAutoScrolling = false
//            displayLink?.invalidate()
//            displayLink = nil
//        }
//
//    func startAutoScrollUpwards() {
//        guard !isAutoScrolling else { return }
//
//        isAutoScrolling = true
//        displayLink = CADisplayLink(target: self, selector: #selector(autoScrollUpwards))
//        displayLink?.add(to: .main, forMode: .common)
//    }
//
//    @objc func autoScrollUpwards() {
//        // Adjust the scrolling speed as needed
//        let scrollingSpeed: CGFloat = 5.0
//
//        let newContentOffsetY = mailListCollectionView.contentOffset.y - scrollingSpeed
//        
//        // Check if reaching the top
//        if newContentOffsetY < 0 {
//            // Stop auto-scrolling
//            stopAutoScroll()
//            return
//        }
//
//        mailListCollectionView.setContentOffset(CGPoint(x: 0, y: newContentOffsetY), animated: false)
//    }
//
//    @objc func autoScroll() {
//        // Adjust the scrolling speed as needed
//        let scrollingSpeed: CGFloat = 5.0
//
//        let newContentOffsetY = mailListCollectionView.contentOffset.y + scrollingSpeed
//        
//        // Check if reaching the bottom
//        if newContentOffsetY > mailListCollectionView.contentSize.height - mailListCollectionView.bounds.height {
//            // Stop auto-scrolling
//            stopAutoScroll()
//            return
//        }
//
//        mailListCollectionView.setContentOffset(CGPoint(x: 0, y: newContentOffsetY), animated: false)
//    }

//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//            if gestureRecognizer == panGesture {
//                // Check if the pan gesture is within the left 100 points
//                let touchPoint = gestureRecognizer.location(in: view)
//                if touchPoint.x < 100 {
//                    // Do not recognize simultaneously if swiping in the left 100 points
//                    return false
//                }
//            }
//            // Recognize simultaneously for other cases
//            return true
//        }
//    deinit {
//        if let panGesture = panGesture {
//            view.removeGestureRecognizer(panGesture)
//        }
//    }

}
