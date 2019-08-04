//
//  SubmitButtonCell.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class SubmitButtonView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var submitButton: PMPButton!

    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
        //self.view = loadViewFromNib() as! CustomView
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
        self.loadFontsAndColors()
        
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: "SubmitButtonView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func loadFontsAndColors() {
        
//        var gradientLayer = CAGradientLayer()
        
//        gradientLayer.startPoint = CGPoint.init(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint.init(x:1.0, y:0.5)
        
//        gradientLayer = CAGradientLayer()
//
//        gradientLayer.frame = self.submitButton.bounds
//
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
//
//        self.submitButton.layer.addSublayer(gradientLayer)
        
        
        self.submitButton.layer.cornerRadius = 10
        self.submitButton.clipsToBounds = true
        
        self.submitButton.backgroundColor = UIColor.PMPYellow
    }

}
