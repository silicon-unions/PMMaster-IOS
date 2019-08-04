//
//  AskInstructorTableViewCell.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class AskInstructorTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var statusLabelWidthConstraint: NSLayoutConstraint!
    
    static let identifier = "AskInstructorTableViewCell"
    static let nibName = "AskInstructorTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(instructorQues : InstructorQuestion){
        self.titleLabel.text = instructorQues.questionString
        if instructorQues.isSeen == false && instructorQues.answerString != nil{
            if (instructorQues.answerString?.count)! > 0{
                self.newImageView.image = #imageLiteral(resourceName: "new image")
            }else{
                self.newImageView.image = nil
            }
        }else{
            self.newImageView.image = nil
        }
        
        self.dateLabel.text = instructorQues.updatedDate
        if let answer = instructorQues.answerString{
            if answer.count > 0{
                self.statusLabel.text = "Asked"
            }else{
                self.statusLabel.text = "Not Asked"
            }
        }
        self.statusLabel.text = "Not Asked"
    }
    
    func configureCell(userNote : UserNoteFull){
        self.titleLabel.text = userNote.note
        self.newImageView.image = nil
        self.statusLabel.text = ""
        self.statusLabelWidthConstraint.constant = 0.0
        self.dateLabel.text = userNote.noteUpdatedDate
    }
    
    func applyShadow() {
        
        innerView.layer.shadowColor = UIColor.black.cgColor
        innerView.layer.shadowOpacity = 1
        innerView.layer.shadowOffset = CGSize.zero
        innerView.layer.shadowRadius = 2
        
        
        innerView.layer.cornerRadius = 5
        innerView.layer.masksToBounds = false
    
    }
    
}
