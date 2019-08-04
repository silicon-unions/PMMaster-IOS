//
//  UITextField+BottomLine.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setBottomLine() {
        
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = UIColor.lightGray
        self.addSubview(borderLine)
    }
    
}
