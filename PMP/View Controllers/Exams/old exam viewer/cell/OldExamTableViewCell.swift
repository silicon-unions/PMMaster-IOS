//
//  OldExamTableViewCell.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/25/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class OldExamTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var infoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
