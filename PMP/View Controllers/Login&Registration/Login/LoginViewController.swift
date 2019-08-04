//
//  LoginViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import UserNotifications
import FacebookLogin
import FBSDKCoreKit
import Alamofire
import LinkedinSwift
import IOSLinkedInAPIFix

class LoginViewController: BaseViewController{

    @IBOutlet weak var inputSectionsTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstranit: NSLayoutConstraint!
    @IBOutlet weak var faceBookView: UIView!
    @IBOutlet weak var submitView: SubmitButtonView!
    var loginPresenter = LoginPresenter()
    
    let configs = LinkedinSwiftConfiguration.init(clientId: "86firwnq38kb7l", clientSecret: "ffekaDiI4YBcS77G", state: "jhgjhgjhgjhg", permissions: ["r_basicprofile", "r_emailaddress"], redirectUrl: "https://professionalengineers.us")
    
    var linkedinHelper : LinkedinSwiftHelper?
    
    
    
    
    public static func create() -> LoginViewController {
        return UIStoryboard(name: "LoginAndRegistration", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! LoginViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkedinHelper = LinkedinSwiftHelper.init(configuration: configs!)
        
        loginPresenter.attachView(view: self.view)
        self.inputSectionsTableView.delegate = self
        self.inputSectionsTableView.dataSource = self
        
        self.submitView.submitButton.isUserInteractionEnabled = false
        self.submitView.submitButton.backgroundColor = UIColor.lightGray
        self.submitView.submitButton.setTitleColor(UIColor.darkGray, for: .normal)
        
        inputSectionsTableView.register(UINib(nibName: InputSectionViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: InputSectionViewCell.identifier)
//        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = true
        submitView.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: UIControlEvents.touchUpInside)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        
        
//        LoginViewController.setUpLocalNotificationForExamDate()
//        LoginViewController.setUpLocalNotificationForStudyTime()
        
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ,.email])
//        loginButton.center = self.view.center
        loginButton.delegate = self
        
        
        self.faceBookView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        faceBookView.translatesAutoresizingMaskIntoConstraints = false
        self.faceBookView.addConstraints([
            NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: self.faceBookView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: loginButton, attribute: .centerY, relatedBy: .equal, toItem: self.faceBookView, attribute: .centerY, multiplier: 1.0, constant: 0)
            ])
    }
    
    class func setUpLocalNotificationForStudyTime() {
        let center = UNUserNotificationCenter.current()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard (UserDefaults.standard.value(forKey: appDelegate!.studyTimeKey) != nil) else {
            return
        }

        let studyTimeDate = UserDefaults.standard.value(forKey: (appDelegate?.studyTimeKey)!) as! Date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: studyTimeDate)
        let minute = calendar.component(.minute, from: studyTimeDate)
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("GRANTED TO SEND LOCAL NOTIFICATION")
            } else {
                print("NOT GRANTED TO SEND LOCAL NOTIFICATION")
            }
        }
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Time To Study"
        content.body = "Don't Miss Your Study Time"
        content.categoryIdentifier = "customIdentifier"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    class func setUpLocalNotificationForExamDate() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        guard (UserDefaults.standard.value(forKey: appDelegate!.examDateKey) != nil) else {
            return
        }
        
        
        let studyTimeDate = UserDefaults.standard.value(forKey: (appDelegate?.examDateKey)!) as! Date
        let calendar = Calendar.current
        let year = calendar.component(.year, from: studyTimeDate) - 2
        let month = calendar.component(.month, from: studyTimeDate)
        let day = calendar.component(.day, from: studyTimeDate)
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("GRANTED TO SEND LOCAL NOTIFICATION")
            } else {
                print("NOT GRANTED TO SEND LOCAL NOTIFICATION")
            }
        }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Title goes here"
        content.body = "Main text goes here"
        content.categoryIdentifier = "customIdentifier"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    override func viewDidLayoutSubviews() {
        tableViewHeightConstranit.constant = inputSectionsTableView.contentSize.height
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func submitButtonPressed() {
        let isValid = self.validateAllEntries()
        print(isValid)

//        if !isValid{
//            return
//        }

        let loginService = LoginService()
        let userModel = LoginService.LoginModel.init(userName: self.dataForCellAtIndex(index: 0), password: self.dataForCellAtIndex(index: 1))
        self.showSpinner()
        loginService.start(params: ["email":userModel.userName,"password":userModel.password]) { (model, error) in
            
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
            if let success = (model as! LoginResponseModel).success{
                if success{
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.authenToken = (model as! LoginResponseModel).token!
                    appDelegate.newlyLoggedIn = true
                    let defaults:UserDefaults = UserDefaults.standard
                    defaults.set(userModel.userName, forKey: "userName")
                    defaults.set(userModel.password, forKey: "password")
                    self.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: true)
                    
                    
                    
                }else{
                    self.showDefaultAlert(message: (model as! LoginResponseModel).reason!, popView: false)
                }
            }
        }
    }
    
    
//    func begin() {
//
//        if let data = UIImageJPEGRepresentation(selectedImages,1) {
//            let parameters: Parameters = [
//                "access_token" : "YourToken"
//            ]
//            // You can change your image name here, i use NSURL image and convert into string
//            let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//            let fileName = imageURL.absouluteString
//            // Start Alamofire
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                for (key,value) in parameters {
//                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//                }
//                multipartFormData.append(data, withName: "avatar", fileName: fileName!,mimeType: "image/jpeg")
//            },
//                             usingTreshold: UInt64.init(),
//                             to: "YourURL",
//                             method: .Po,
//                             encodingCompletion: { encodingResult in
//                                switch encodingResult {
//                                case .success(let upload, _, _):
//                                    upload.responJSON { response in
//                                        debugPrint(response)
//                                    }
//                                case .failure(let encodingError):
//                                    print(encodingError)
//                                }
//            })
//        }
//    }
    @IBAction func loginWithLinkedIn() {
        
        linkedinHelper?.authorizeSuccess({ [unowned self] (lsToken) -> Void in
            
            print("Login success lsToken: \(lsToken)")
            self.linkedinHelper?.requestURL("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url,picture-urls::(original),positions,date-of-birth,phone-numbers,location)?format=json", requestType: LinkedinSwiftRequestGet, success: { (response) -> Void in
                
                print("Request success with response: \(response)")
                
                let loginService = LoginService()
                self.showSpinner()
                
                loginService.startwithLinkedIn(params: ["email":response.jsonObject["emailAddress"] as! String,"linkedInId":response.jsonObject["id"] as! String], completionHandler: { (model, error) in
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
                    if let success = (model as! LoginResponseModel).success{
                        if success{
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.authenToken = (model as! LoginResponseModel).token!
                            appDelegate.newlyLoggedIn = true
                            self.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: true)
                            
                            
                            
                        }else{
                            self.showDefaultAlert(message: (model as! LoginResponseModel).reason!, popView: false)
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
    
    func validateAllEntries() -> Bool{
        for i in 0...1{
            let cell = self.inputSectionsTableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as! InputSectionViewCell
            
            
            let expressionTest = NSPredicate(format:"SELF MATCHES %@", self.loginPresenter.inputDataModels![i].regularExpression!)
            if !expressionTest.evaluate(with: cell.inputSectionView.inputTextField.text){
                return false
            }
        }
        return true
    }
    
    func dataForCellAtIndex(index:Int) -> String {        
        
        return (self.inputSectionsTableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension LoginViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputSectionViewCell.identifier) as! InputSectionViewCell
        if indexPath.row == 0 {
            cell.inputSectionView.imageView.image = #imageLiteral(resourceName: "profile image")
            cell.inputSectionView.inputTextField.textContentType = UITextContentType.emailAddress
            cell.inputSectionView.inputTextField.isSecureTextEntry = false
        }else{
            cell.inputSectionView.imageView.image = #imageLiteral(resourceName: "password image")
            cell.inputSectionView.inputTextField.textContentType = UITextContentType.password
            cell.inputSectionView.inputTextField.isSecureTextEntry = true
        }
        cell.delegate = self
        cell.configureCell(inputModel: loginPresenter.prepareDataModels()[indexPath.row])
        return cell
    }
}
extension LoginViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension LoginViewController : LoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult){
//        if let accessToken = FBSDKAccessToken.current() {
//            print(accessToken.userID)
//
//            let req = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"name,email"], httpMethod: "GET")
//            req?.start(completionHandler: { (connection, result, error) in
//                if(error == nil)
//                {
//                    print("result \(result)")
//                    print (result.objectForKey("email"))
//                }
//                else
//                {
//                    print("error \(error)")
//                }
//
//
//            })
//
//        }
        
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "email, name, id, gender"])
            .start(completionHandler:  { (connection, result, error) in
                if let result = result as? NSDictionary, let email = result["email"] as? String,
                    let user_id_fb = result["id"]  as? String {
                    let loginService = LoginService()
                    self.showSpinner()
                    loginService.startwithFB(params: ["email":email,"facebookId":user_id_fb]) { (model, error) in
                        
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
                        if let success = (model as! LoginResponseModel).success{
                        if success{
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.authenToken = (model as! LoginResponseModel).token!
                        appDelegate.newlyLoggedIn = true
                        self.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: true)
                        
                        
                        
                        }else{
                        self.showDefaultAlert(message: (model as! LoginResponseModel).reason!, popView: false)
                        }
                    }
                }
            }
        })
    }
}

extension LoginViewController : InputSectionViewCellDelegate{
    func didStartEditingTextField(inputSectionView:InputSectionView){
        
    }
    func didFinishEditingTextField(inputSectionView:InputSectionView){
        if self.dataForCellAtIndex(index: 0).count > 0 && self.dataForCellAtIndex(index: 1).count > 0{
            self.submitView.submitButton.isUserInteractionEnabled = true
            self.submitView.submitButton.backgroundColor = UIColor.PMPYellow
            self.submitView.submitButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
