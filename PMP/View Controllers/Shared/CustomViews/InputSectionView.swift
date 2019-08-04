//
//  PrepaidTopUpAlertView.swift
//  MyVodafone
//
//  Created by Mohammed Ahmed on 1/21/18.
//  Copyright © 2018 TSSE. All rights reserved.
//

import UIKit

class InputSectionView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var highlightedView: UIView!
    
    enum DisplayMode {
        case normal
        case error
        case highlighted
    }
    
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
        self.setupInputTextField()
        
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: "InputSectionView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setupInputTextField() {
        self.inputTextField.textColor = UIColor.darkGray
    }
    
    func loadFontsAndColors() {
    }
    
    func changeDisplayMode(mode : DisplayMode) {
        switch mode {
        case .normal:
            self.lineView.backgroundColor = UIColor.white
            self.messageLabel.textColor = UIColor.white
        case .highlighted:
            self.lineView.backgroundColor = UIColor.white
            self.messageLabel.textColor = UIColor.white
        case .error:
            self.lineView.backgroundColor = UIColor.PMPred
            self.messageLabel.textColor = UIColor.PMPred
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

}
