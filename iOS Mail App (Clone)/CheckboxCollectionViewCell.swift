//
//  CheckboxCollectionViewCell.swift
//  iOS Mail App (Clone)
//
//  Created by ヴィヤヴャハレ・アディティヤ on 22/11/23.
//

import UIKit

class CheckboxCollectionViewCell: UICollectionViewCell {
    let roundCheckbox = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Configure the checkbox view
            roundCheckbox.backgroundColor = .clear
        roundCheckbox.layer.cornerRadius = 10.5
            roundCheckbox.layer.borderWidth = 1
            roundCheckbox.layer.borderColor = UIColor.systemGray.cgColor
//        roundCheckbox.isHidden = true

            contentView.addSubview(roundCheckbox)
//        roundCheckboxLeadingConstraint = roundCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -20)
//                roundCheckboxLeadingConstraint?.isActive = true
        roundCheckbox.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                // Position the checkbox on the left side of the cell
                roundCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                roundCheckbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                roundCheckbox.widthAnchor.constraint(equalToConstant: 21),
                roundCheckbox.heightAnchor.constraint(equalToConstant: 21),
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
