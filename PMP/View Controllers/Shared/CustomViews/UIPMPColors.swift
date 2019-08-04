//
//  UIPMPColors.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

extension UIColor{
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    public static var PMPgray : UIColor {
        get {
            return UIColor.init(red: 220.0/256.0, green: 220.0/256.0, blue: 220.0/256.0, alpha: 1.0)
        }
    }
    
    public static var PMPBlue : UIColor {
        get {
            return UIColor.init(red: 0.0/256.0, green: 121.0/256.0, blue: 194.0/256.0, alpha: 1.0)
        }
    }
    
    public static var PMPNewBlue : UIColor {
        get {
            return UIColor.init(red: 1.0/256.0, green: 118.0/256.0, blue: 233.0/256.0, alpha: 1.0)
        }
    }
    
    public static var PMPYellow : UIColor {
        get {
            return UIColor.init(red: 248.0/256.0, green: 207.0/256.0, blue: 91.0/256.0, alpha: 1.0)
        }
    }
    
    public static var PMPred : UIColor {
        get {
            return UIColor.init(red: 229.0/256.0, green: 87.0/256.0, blue: 47.0/256.0, alpha: 1.0)
        }
    }
    
    public static var PMPGreen : UIColor {
        get {
            return UIColor.init(red: 47.0/256.0, green: 163.0/256.0, blue: 160.0/256.0, alpha: 1.0)
        }
    }
    
    public static var PMPGreyBckColor : UIColor {
        get {
            return UIColor.init(red: 240.0/256.0, green: 240/256.0, blue: 240.0/256.0, alpha: 1.0)
        }
    }
    
    public static var PMPHighlightGreyBckColor : UIColor {
        get {
            return UIColor.init(red: 200.0/256.0, green: 200.0/256.0, blue: 200.0/256.0, alpha: 1.0)
        }
    }
}
