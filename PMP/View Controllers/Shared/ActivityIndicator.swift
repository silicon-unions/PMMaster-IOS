//
//  ADIBMFPActivityIndicator.swift
//  ActivityIndicator
//
//  Created by Deepak Srinivas on 25/02/16.
//
/*******************************************************
 * Copyright (C) 2016 Abu Dhabi Islamic Bank>
 *
 * This file is part of Abu Dhabi mobile banking project.
 *
 * This file cannot be copied and/or distributed without the express
 * permission of Abu Dhabi Islamic Bank
 *******************************************************/

import UIKit

class ActivityIndicator: UIView {
    
    var activityIndicator: UIActivityIndicatorView?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator?.transform = transform
        activityIndicator?.center = self.center
        activityIndicator?.startAnimating()
        
        
        
        self.addSubview(activityIndicator!)
    }

}


class PMPActivityIndicator: UIView {
    
    var imageView : UIImageView?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let loadingImages = (1...20).map { UIImage(named: "spinner\($0)")! }
        let viewx = ((rect.size.width) / 2) - 20
        let viewy = ((rect.size.height) / 2 ) - 20
        imageView = UIImageView(frame: CGRect(x: viewx, y: viewy, width: 40, height: 40))
        imageView?.animationImages = loadingImages
        imageView?.animationDuration = 1.0
        imageView?.startAnimating()
        
        self.addSubview(imageView!)
    }
    
}

class PMPTextActivityIndicator: UIView {
    
    var imageView : UIImageView?
    var titleLabel : UILabel?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let loadingImages = (1...20).map { UIImage(named: "spinner\($0)")! }
        let viewx = ((rect.size.width) / 2) - 20
        let viewy = ((rect.size.height) / 2 ) - 20
        imageView = UIImageView(frame: CGRect(x: viewx, y: viewy, width: 40, height: 40))
        imageView?.animationImages = loadingImages
        imageView?.animationDuration = 1.0
        imageView?.startAnimating()
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: viewy + 50, width: 400, height: 40))
        titleLabel?.textAlignment = .center
        titleLabel?.text = "Please wait, We're downloading contents..."
        
        self.addSubview(imageView!)
        self.addSubview(titleLabel!)
    }
}
