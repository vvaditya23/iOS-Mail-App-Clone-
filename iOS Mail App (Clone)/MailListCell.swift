//
//  MailListCell.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class MailListCell: UICollectionViewCell {
    
    let senderLabel = UILabel()
    let subjectLabel = UILabel()
    let mailContentLabel = UILabel()
    let roundCheckbox = UIView()
    let separatorLine = UIView()
    let timeLabel = UILabel()
    let arrowLabel = UILabel()
    
    //leading constraints that are over-written when in editing mode
    private var senderLeadingConstraint: NSLayoutConstraint?
    private var subjectLeadingConstraint: NSLayoutConstraint?
    private var dateLeadingConstraint: NSLayoutConstraint?
    private var separatorLeadingConstraint: NSLayoutConstraint?
    private var roundCheckboxLeadingConstraint: NSLayoutConstraint?
    private var arrowTrailingAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ///viewDidLoad
        // Add custom separator line
        separatorLine.backgroundColor = UIColor.separator
                separatorLine.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(separatorLine)
        separatorLeadingConstraint = separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        separatorLeadingConstraint?.isActive = true
        NSLayoutConstraint.activate([
//                    separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    separatorLine.heightAnchor.constraint(equalToConstant: 1)
                ])
        
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
        
        //declaring just the leading constraints so that it can be modified further
        senderLeadingConstraint = senderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
                senderLeadingConstraint?.isActive = true
        subjectLeadingConstraint = subjectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        subjectLeadingConstraint?.isActive = true
        dateLeadingConstraint = mailContentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        dateLeadingConstraint?.isActive = true
        
        //rest of the constraints
        NSLayoutConstraint.activate([
            senderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            senderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            senderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            subjectLabel.topAnchor.constraint(equalTo: senderLabel.bottomAnchor, constant: 8),
//            subjectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subjectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            mailContentLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 8),
//            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mailContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mailContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: arrowLabel.trailingAnchor, constant: -15),
            
            arrowLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
//            arrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
        // Configure the checkbox view
            roundCheckbox.backgroundColor = .clear
        roundCheckbox.layer.cornerRadius = 10.5
            roundCheckbox.layer.borderWidth = 1
            roundCheckbox.layer.borderColor = UIColor.systemGray.cgColor
//        roundCheckbox.isHidden = true

            contentView.addSubview(roundCheckbox)
        roundCheckboxLeadingConstraint = roundCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -20)
                roundCheckboxLeadingConstraint?.isActive = true
        roundCheckbox.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                // Position the checkbox on the left side of the cell
//                roundCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                roundCheckbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                roundCheckbox.widthAnchor.constraint(equalToConstant: 21),
                roundCheckbox.heightAnchor.constraint(equalToConstant: 21),
            ])
        arrowTrailingAnchor = arrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        arrowTrailingAnchor?.isActive = true
        
        roundCheckbox.clipsToBounds = true
    }

    override var isSelected: Bool {
            didSet {
                // Update the appearance of the cell and checkbox based on the selection state
                if isSelected {
                    // Cell is selected
                    contentView.backgroundColor = .systemGray5 // Set the cell background to grey
//                    roundCheckbox.backgroundColor = .systemBlue // Set the checkbox background to blue
                    let image = UIImage(systemName: "checkmark.circle.fill")
//                    let image = UIImage(systemName: "")
                    let imageView = UIImageView(image: image)
                    imageView.frame = roundCheckbox.bounds
                    imageView.contentMode = .scaleAspectFit
                                imageView.layer.cornerRadius = roundCheckbox.layer.cornerRadius
//                                imageView.clipsToBounds = true
//                    imageView.backgroundColor = .red
                    roundCheckbox.addSubview(imageView)
                    roundCheckbox.layer.borderColor = UIColor.clear.cgColor
                } else {
                    // Cell is deselected
                    contentView.backgroundColor = .white // Set the cell background to white or any other desired color
//                    roundCheckbox.backgroundColor = .clear // Set the checkbox background to clear
                    // Remove any existing subviews from roundCheckbox
                                roundCheckbox.subviews.forEach { $0.removeFromSuperview() }
                    roundCheckbox.layer.borderColor = UIColor.systemGray.cgColor
                }
            }
        }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            resetState()
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MailListCell {
    func moveLabelsToRight() {
        senderLeadingConstraint?.constant = 50
        subjectLeadingConstraint?.constant = 50
        dateLeadingConstraint?.constant = 50
        separatorLeadingConstraint?.constant = 50
        roundCheckboxLeadingConstraint?.constant = 10
        arrowTrailingAnchor?.constant = 10
        
        // Change alpha value to create a fading effect
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.roundCheckbox.alpha = 1
                }, completion: nil)
    }

    func moveLabelsToOriginalPosition() {
        senderLeadingConstraint?.constant = 16
        subjectLeadingConstraint?.constant = 16
        dateLeadingConstraint?.constant = 16
        separatorLeadingConstraint?.constant = 16
        roundCheckboxLeadingConstraint?.constant = -20
        arrowTrailingAnchor?.constant = -5
        
        // Change alpha value to create a fading effect
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.roundCheckbox.alpha = 0
                }, completion: nil)
    }
    
    func resetState() {
            // Reset any state changes made during editing mode
            moveLabelsToOriginalPosition()
            // ... reset any other state changes ...
        }
}
