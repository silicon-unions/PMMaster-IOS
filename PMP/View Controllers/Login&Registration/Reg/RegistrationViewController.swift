//
//  RegistrationViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FacebookLogin
import LinkedinSwift
import IOSLinkedInAPIFix

class RegistrationViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: RegistrationPresentation!
    var responseData = [String : AnyObject]()
    var tokenData : String?
    
    @IBOutlet weak var faceBookView: UIView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitView: SubmitButtonView!
    
    let configs = LinkedinSwiftConfiguration.init(clientId: "86firwnq38kb7l", clientSecret: "ffekaDiI4YBcS77G", state: "jhgjhgjhgjhg", permissions: ["r_basicprofile", "r_emailaddress"], redirectUrl: "https://professionalengineers.us")
    
    var linkedinHelper : LinkedinSwiftHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkedinHelper = LinkedinSwiftHelper.init(configuration: configs!)
        presenter = RegistrationPresenter()
        (presenter as! RegistrationPresenter).view = self
        
        self.submitView.submitButton.isUserInteractionEnabled = false
        self.submitView.submitButton.backgroundColor = UIColor.lightGray
        self.submitView.submitButton.setTitleColor(UIColor.darkGray, for: .normal)
        
        tableView.register(UINib(nibName: InputSectionViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: InputSectionViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        submitView.submitButton.setTitle("SEND", for: UIControlState.normal)
        
        submitView.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ,.email])
        loginButton.delegate = self
        self.faceBookView.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        faceBookView.translatesAutoresizingMaskIntoConstraints = false
        self.faceBookView.addConstraints([
            NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: self.faceBookView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: loginButton, attribute: .centerY, relatedBy: .equal, toItem: self.faceBookView, attribute: .centerY, multiplier: 1.0, constant: 0)
            ])
        
    }
    @objc func submitButtonPressed() {
        
        let isValid = self.validateAllEntries()
        print(isValid)
        guard isValid else {
            return
        }
        
        self.presenter.register()
    }
    
    func validateAllEntries() -> Bool{
        for i in 0...3{
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as! InputSectionViewCell
            
            
            let expressionTest = NSPredicate(format:"SELF MATCHES %@", (self.presenter as! RegistrationPresenter).inputDataModels![i].regularExpression!)
            if !expressionTest.evaluate(with: cell.inputSectionView.inputTextField.text){
                return false
            }
        }
        
        if self.dataForCellAtIndex(index: 2) != self.dataForCellAtIndex(index: 1){
            (self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! InputSectionViewCell).inputSectionView.changeDisplayMode(mode: .error)
            (self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! InputSectionViewCell).inputSectionView.messageLabel.text = "Passwords are not matched"
            return false
        }
        
        return true
    }
    
    override func viewDidLayoutSubviews() {
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataForCellAtIndex(index:Int) -> String {
        return (self.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func loginWithLinkedIn() {
        
        linkedinHelper?.authorizeSuccess({ [unowned self] (lsToken) -> Void in
            
            print("Login success lsToken: \(lsToken)")
            self.tokenData = lsToken.accessToken
            
            self.linkedinHelper?.requestURL("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url,picture-urls::(original),positions,date-of-birth,phone-numbers,location)?format=json", requestType: LinkedinSwiftRequestGet, success: { (response) -> Void in
                
                print("Request success with response: \(response.jsonObject)")
                
                
                let registrationService = RegistrationService()
                self.showSpinner()
                registrationService.startWithLinkedIn(params: ["name":response.jsonObject["lastName"] as! String,"email":response.jsonObject["emailAddress"] as! String,"linkedInId":response.jsonObject["id"] as! String], completionHandler: { (model, error) in
                    if error != nil {
                        if let errorMsg = error?.localizedDescription {
                            self.showDefaultAlert(message: errorMsg, popView: false)
                        }else{
                            self.showDefaultAlert(message: "General Error", popView: false)
                        }
                        self.hideSpinner()
                        return
                    }
                    
                    self.hideSpinner()
                    if let success = (model as! RegistrationModel).success{
                        if success{
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.authenToken = (model as! RegistrationModel).apiToken!
                            self.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: true)
                            
                            
                            
                        }else{
                            self.showDefaultAlert(message: (model as! RegistrationModel).reason!, popView: false)
                        }
                    }
                })
                
                
            }) { /*[unowned self]*/ (error) -> Void in
                
                print("Encounter error: \(error.localizedDescription)")
            }
            
            }, error: { /*[unowned self]*/ (error) -> Void in
                
                print("Encounter error: \(error.localizedDescription)")
        }, cancel: { /*[unowned self]*/ () -> Void in
            
            print("User Cancelled!")
        })
    }
}

extension RegistrationViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputSectionViewCell.identifier) as! InputSectionViewCell
        
        cell.configureCell(inputModel: presenter.prepareDataModels()[indexPath.row])
        cell.delegate = self
        
        if indexPath.row == 0 || indexPath.row == 3{
            cell.inputSectionView.imageView.image = #imageLiteral(resourceName: "profile image")
        }else{
            cell.inputSectionView.imageView.image = #imageLiteral(resourceName: "password image")
        }
        return cell
    }
}
extension RegistrationViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension RegistrationViewController: RegistrationView {
    // TODO: implement view output methods
}

extension RegistrationViewController : LoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult){
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "email, name, id, gender"])
            .start(completionHandler:  { (connection, result, error) in
                if let result = result as? NSDictionary, let email = result["email"] as? String,
                    let user_name = result["name"] as? String,
                    let user_id_fb = result["id"]  as? String{
                    (self.presenter as! RegistrationPresenter).registerViaFacebook(params: ["name":user_name,"email":email,"facebookId":user_id_fb])
                }else{
                    return
                }
            })
    }
}

extension RegistrationViewController : InputSectionViewCellDelegate{
    func didFinishEditingTextField(inputSectionView: InputSectionView) {
        if self.validateAllEntries() == true{
            self.submitView.submitButton.isUserInteractionEnabled = true
            self.submitView.submitButton.backgroundColor = UIColor.PMPYellow
            self.submitView.submitButton.setTitleColor(UIColor.white, for: .normal)
        }else{
            self.submitView.submitButton.isUserInteractionEnabled = false
            self.submitView.submitButton.backgroundColor = UIColor.lightGray
            self.submitView.submitButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
    }
    
    func didStartEditingTextField(inputSectionView: InputSectionView) {
    }
}
