//
//  MailListCell.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class NotesCell: UICollectionViewCell {
    
    
    var label = UILabel()
    
    let senderLabel = UILabel()
    let subjectLabel = UILabel()
    let mailContentLabel = UILabel()
    var circleView = UIView()
    var circle = UIImageView()
    let separatorLine = UIView()
    let timeLabel = UILabel()
    let arrowLabel = UILabel()
    
    var panGesture: UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupPanGesture()
        backgroundColor = .systemGray6
        
        senderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        senderLabel.textColor = UIColor.black
        senderLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(senderLabel)

        subjectLabel.font = UIFont.systemFont(ofSize: 16)
        subjectLabel.textColor = UIColor.black
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subjectLabel)

        mailContentLabel.font = UIFont.systemFont(ofSize: 12)
        mailContentLabel.textColor = UIColor.gray
        mailContentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mailContentLabel)

        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        
        arrowLabel.font = UIFont.boldSystemFont(ofSize: 12)
        arrowLabel.textColor = UIColor.gray
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowLabel)
        
        circleView.backgroundColor = .systemGray3
        addSubview(circleView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        circleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        circleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            senderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            senderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            senderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            subjectLabel.topAnchor.constraint(equalTo: senderLabel.bottomAnchor, constant: 8),
            subjectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            subjectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            mailContentLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 8),
//            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mailContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mailContentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            mailContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: arrowLabel.trailingAnchor, constant: -15),
            
            arrowLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            arrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
        circleView.addSubview(circle)
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 30).isActive = true
        circle.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        circle.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        
        circle.layer.cornerRadius = 15
        circle.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension NotesCell {
//    private func setupPanGesture() {
//            panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
//            circle.addGestureRecognizer(panGesture)
//            circle.isUserInteractionEnabled = true
//        }
//    
//    @objc func handlePan(gesture: UIPanGestureRecognizer) {
//        let location = gesture.location(in: mailListCollectionView)
//        
//        switch gesture.state {
//        case .began:
//            if let indexPath = mailListCollectionView.indexPathForItem(at: location) {
//                initialIndexPath = indexPath
//                selectedIndexPaths.insert(indexPath)
//                updateCellSelection(at: indexPath, isSelected: true)
//            }
//        case .changed:
//            if let initialIndexPath = initialIndexPath {
//                if let indexPath = mailListCollectionView.indexPathForItem(at: location), indexPath != initialIndexPath {
//                    let currentDirection = calculateDirection(of: gesture)
//                    
//                    if currentDirection == .down {
//                        deselectCells(from: indexPath, to: initialIndexPath)
//                    } else {
//                        deselectCells(from: initialIndexPath, to: indexPath)
//                    }
//                }
//            }
//        case .ended, .cancelled:
//            initialIndexPath = nil
//        default:
//            break
//        }
//    }
//
//}
