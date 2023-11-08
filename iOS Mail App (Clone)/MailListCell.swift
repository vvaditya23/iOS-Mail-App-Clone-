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
    let dateLabel = UILabel()
    let roundCheckbox = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        ///viewDidLoad

        senderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        senderLabel.textColor = UIColor.black
        senderLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(senderLabel)

        subjectLabel.font = UIFont.systemFont(ofSize: 16)
        subjectLabel.textColor = UIColor.black
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subjectLabel)

        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.gray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)

        // Add layout constraints for your labels
        // Example constraints (customize as needed):
        NSLayoutConstraint.activate([
            senderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            senderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            senderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            subjectLabel.topAnchor.constraint(equalTo: senderLabel.bottomAnchor, constant: 8),
            subjectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subjectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dateLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Configure the checkbox view
            roundCheckbox.backgroundColor = .clear
            roundCheckbox.layer.cornerRadius = 10
            roundCheckbox.layer.borderWidth = 1
            roundCheckbox.layer.borderColor = UIColor.systemGray.cgColor
        roundCheckbox.isHidden = true

            contentView.addSubview(roundCheckbox)

        roundCheckbox.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                // Position the checkbox on the left side of the cell
                roundCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                roundCheckbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                roundCheckbox.widthAnchor.constraint(equalToConstant: 20),
                roundCheckbox.heightAnchor.constraint(equalToConstant: 20),
            ])
    }

    override var isSelected: Bool {
            didSet {
                // Update the appearance of the cell and checkbox based on the selection state
                if isSelected {
                    // Cell is selected
                    contentView.backgroundColor = .lightGray // Set the cell background to grey
                    roundCheckbox.backgroundColor = .systemBlue // Set the checkbox background to blue
                } else {
                    // Cell is deselected
                    contentView.backgroundColor = .white // Set the cell background to white or any other desired color
                    roundCheckbox.backgroundColor = .clear // Set the checkbox background to clear
                }
            }
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
