//
//  MailListCell.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 04/11/23.
//

import UIKit

class MailListCell: UICollectionViewCell {
    let identifier = "CellIdentifier"
    
    let senderLabel = UILabel()
    let subjectLabel = UILabel()
    let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        ///viewDidLoad

        senderLabel.font = UIFont.systemFont(ofSize: 16)
        senderLabel.textColor = UIColor.black
        senderLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(senderLabel)

        subjectLabel.font = UIFont.boldSystemFont(ofSize: 18)
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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
