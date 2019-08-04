//
//  ViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let landingVC = LandingRouter.setupModule()
//        self.navigationController?.pushViewController(landingVC, animated: false)//LoginViewController.create()
        
        
        
        
        
    }
    
    func navigate() {
        let defaults:UserDefaults = UserDefaults.standard
        
        if let userName = defaults.string(forKey: "userName") , let password = defaults.string(forKey: "password"){
            if userName.count > 0 && password.count > 0{
                let loginService = LoginService()
                self.showSpinner()
                loginService.start(params: ["email":userName,"password":password]) { (model, error) in
                    
                    if error != nil {
                        self.hideSpinner()
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.newlyLoggedIn = false
                        self.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: false)
                        
                        if let errorMsg = error?.localizedDescription {
                            self.showDefaultAlert(message: errorMsg, popView: false)
                        }else{
                            self.showDefaultAlert(message: "General Error", popView: false)
                        }
                        return
                    }
                    
                    self.hideSpinner()
                    if let success = (model as! LoginResponseModel).success{
                        if success{
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.authenToken = (model as! LoginResponseModel).token!
                            appDelegate.newlyLoggedIn = true
                            self.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: false)
                            
                            
                            
                        }else{
                            self.showDefaultAlert(message: (model as! LoginResponseModel).reason!, popView: false)
                        }
                    }
                }
            }else{
                let landingVC = LandingRouter.setupModule()
                self.navigationController?.pushViewController(landingVC, animated: false)//LoginViewController.create()
            }
        }else{
            let landingVC = LandingRouter.setupModule()
            self.navigationController?.pushViewController(landingVC, animated: false)//LoginViewController.create()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

