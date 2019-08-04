//
//  ADIBMFPSpinner.swift
//  ActivityIndicator
//
//  Created by Deepak Srinivas on 25/02/16.
/*******************************************************
 * Copyright (C) 2016 Abu Dhabi Islamic Bank>
 *
 * This file is part of Abu Dhabi mobile banking project.
 *
 * This file cannot be copied and/or distributed without the express
 * permission of Abu Dhabi Islamic Bank
 *******************************************************/
import UIKit

class Spinner {
    
    static let kSpinnerTag = 99999
    
    
    static func showActivityIndicator(forView view: UIView?) {
        
        
            self.hideActivityIndicator(forView: view)
            if let view = view {
                // load animated images
                let ai = PMPActivityIndicator(frame: view.bounds)
                ai.tag = kSpinnerTag
                view.addSubview(ai)
                ai.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
            }
        
    }
    
    static func showActivityIndicatorWithText(forView view: UIView?) {
        
        
        self.hideActivityIndicator(forView: view)
        if let view = view {
            // load animated images
            let ai = PMPTextActivityIndicator(frame: view.bounds)
            ai.tag = kSpinnerTag
            view.addSubview(ai)
            ai.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        }
        
    }
    
    static func showActivityIndicator(forView view: UIView? , tagIdentifier : Int) {
        
        
            self.hideActivityIndicator(forView: view, tagIdentifier: tagIdentifier)
            if let view = view {
                // load animated images
                let ai = PMPActivityIndicator(frame: view.bounds)
                var tag = tagIdentifier
                if tag == 0 {
                    tag = kSpinnerTag
                }
                
                ai.tag = tag
                
                ai.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
                
                UIView.transition(with: view , duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,
                                  animations:
                    {
                        view.addSubview(ai)
                        ai.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
                        
                }, completion: nil)
                
                
            }
            
        
    }
    
    static func hideActivityIndicator(forView view: UIView?) {
        
            if let view = view {
                if let ai = view.viewWithTag(kSpinnerTag) as? PMPActivityIndicator {
                    ai.removeFromSuperview()
                    
                }
            }
        
    }
    
    static func hideActivityIndicatorWithText(forView view: UIView?) {
        
        if let view = view {
            if let ai = view.viewWithTag(kSpinnerTag) as? PMPTextActivityIndicator {
                ai.removeFromSuperview()
                
            }
        }
        
    }
    
    static func hideActivityIndicator(forView view: UIView? , tagIdentifier : Int) {
        
            var tag = tagIdentifier
            if tag == 0 {
                tag = kSpinnerTag
            }
            
            if let view = view {
                if let ai = view.viewWithTag(tag) as? PMPActivityIndicator {
                    
                    
                    UIView.transition(with: view , duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,
                                      animations:
                        {
                            ai.removeFromSuperview()
                            
                    }, completion: nil)
                    
                    
                    
                }
            }
        
    }
    
    
    
}
