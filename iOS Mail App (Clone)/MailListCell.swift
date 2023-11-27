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
    var checkboxView = UIView()
    var checkbox = UIImageView()
    let separatorLine = UIView()
    let timeLabel = UILabel()
    let arrowLabel = UILabel()
    
    let vc = ViewController()
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    //leading constraints that are over-written when in editing mode
    private var senderLeadingConstraint: NSLayoutConstraint?
    private var subjectLeadingConstraint: NSLayoutConstraint?
    private var dateLeadingConstraint: NSLayoutConstraint?
    private var separatorLeadingConstraint: NSLayoutConstraint?
    private var roundCheckboxLeadingConstraint: NSLayoutConstraint?
    private var arrowTrailingAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .systemGray6
        
        // Add custom separator line
        separatorLine.backgroundColor = UIColor.separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorLine)
        //        separatorLeadingConstraint = separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        //        separatorLeadingConstraint?.isActive = true
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
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
        
        //        checkboxView.backgroundColor = .systemGray3
        addSubview(checkboxView)
        
        checkboxView.translatesAutoresizingMaskIntoConstraints = false
        checkboxView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        checkboxView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        checkboxView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        checkboxView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
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
        
        checkboxView.addSubview(checkbox)
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.heightAnchor.constraint(equalToConstant: 21).isActive = true
        checkbox.widthAnchor.constraint(equalToConstant: 21).isActive = true
        checkbox.centerXAnchor.constraint(equalTo: checkboxView.centerXAnchor).isActive = true
        checkbox.centerYAnchor.constraint(equalTo: checkboxView.centerYAnchor).isActive = true
        checkbox.backgroundColor = .clear
        checkbox.layer.cornerRadius = 10.5
        checkbox.layer.borderWidth = 1
        checkbox.layer.borderColor = UIColor.systemGray.cgColor
        checkbox.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
