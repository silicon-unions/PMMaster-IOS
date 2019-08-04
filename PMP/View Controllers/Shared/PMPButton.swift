//
//  PMPButton.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/15/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class PMPButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.setTitleColor(UIColor.white, for: .normal)
    }
 

}
