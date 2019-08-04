//
//  ProfileViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/18/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class ProfileViewController: BaseViewController{

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    var selectedIndex = -1
    @IBOutlet weak var datePicker : UIDatePicker!
//    var level : String?
    
    @IBAction func uploadProfilePic(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    var presenter: ProfilePresentation?

    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let image = appDelegate.profileImage{
            self.profileImageView.image = image
        }
        (presenter as! ProfilePresenter).callGetProfile()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadProfilePic()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        (presenter as! ProfilePresenter).callGetProfile()
        
//        datePicker.datePickerMode = .time
//        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        
//        self.datePicker.isHidden = true
//        self.datePicker.backgroundColor = UIColor.white
        
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
//        (self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        dismiss(animated:true, completion: nil)
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgData: NSData = NSData(data: UIImageJPEGRepresentation((image), 1)!)
        let imageSize: Int = imgData.length
        
        if imageSize <= 2000000{
//            self.showDefaultAlert(message: "Please select image less than 2MB", popView: false)
            self.upload(profilePic: image)
        }else{
            self.upload(profilePic: image)
        }
        profileImageView.image = image
    }
    
    func upload(profilePic:UIImage) {
        NetworkManager.upload(image: profilePic) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(response.request!)  // original URL request
                    print(response.response!) // URL response
                    print(response.data!)     // server data
                    print(response.result)   // result of response serialization
                    //                        self.showSuccesAlert()
                    //self.removeImage("frame", fileExtension: "txt")
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
                
            }
        }
    }
    
    func downloadProfilePic() {
        let remoteImageURL = URL(string: "http://www.professionalengineers.us/pmpmaster/public/api/profilePicture")!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let headers = ["Authorization":"Bearer " + appDelegate.authenToken,"Accept" : "application/json"]

        indicator.isHidden = false
        indicator.startAnimating()
        indicator.color = UIColor.darkGray
        let request = Alamofire.request(remoteImageURL,method :.get ,headers:headers)
            .responseImage { (response) in
                self.indicator.isHidden = true
                self.indicator.stopAnimating()
                if let image = response.result.value{
                    self.profileImageView.image = image as UIImage
                    appDelegate.profileImage = image as UIImage
                }else{
                    self.profileImageView.image = #imageLiteral(resourceName: "profile")
                    appDelegate.profileImage = nil
                }
                
        }
        debugPrint(request)
        
        
//        Alamofire.request("https://httpbin.org/image/png").responseData { response in
//            debugPrint(response)
//            
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//            }
//        }
        
    }
}

extension ProfileViewController: ProfileView {
    // TODO: implement view output methods
}
extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
}
extension ProfileViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Profile"
    }
}

extension ProfileViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"profileCellId")
        if let titleImage = cell?.viewWithTag(5) as? UIImageView , let titleLabel = cell?.viewWithTag(6) as? UILabel , let subtitleLabel = cell?.viewWithTag(7) as? UILabel{
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            if indexPath.row == 0{
                titleImage.image = #imageLiteral(resourceName: "profile image")
                titleLabel.text = "Edit Profile"
            }else if indexPath.row == 1{
                titleImage.image = #imageLiteral(resourceName: "onTarget image")
                titleLabel.text = "Next Exam Date"

                if let examDate = UserDefaults.standard.value(forKey: (appDelegate?.examDateKey)!){
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy" //"yyyy-MM-dd"
                    dateFormatter.timeZone = TimeZone.current
                    subtitleLabel.text = dateFormatter.string(from: examDate as! Date)
                }else{
                    subtitleLabel.text = "not defined"
                }
                
            }else if indexPath.row == 2{
                titleImage.image = #imageLiteral(resourceName: "study time image")
                titleLabel.text = "Preferred Study Time"
                if let examDate = UserDefaults.standard.value(forKey: (appDelegate?.studyTimeKey)!){
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:MM" //"yyyy-MM-dd"
                    dateFormatter.timeZone = TimeZone.current
                    
                    let studyTimeDate = UserDefaults.standard.value(forKey: (appDelegate?.studyTimeKey)!) as! Date
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: studyTimeDate)
                    let minute = calendar.component(.minute, from: studyTimeDate)
                    
                    subtitleLabel.text = "\(String(format: "%02d", hour)):\(String(format: "%02d", minute))"
                }else{
                    subtitleLabel.text = "not defined"
                }
                
            }else if indexPath.row == 3{
                titleImage.image = #imageLiteral(resourceName: "about")
                titleLabel.text = "About"
            }else if indexPath.row == 4{
                titleImage.image = #imageLiteral(resourceName: "logout image")
                titleLabel.text = "Log Out"
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
extension ProfileViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0{
            selectedIndex = 0
            self.navigationController?.pushViewController(ProfileUpdateRouter.setupModule(), animated: true)
        }
        if indexPath.row == 1{
            selectedIndex = 1
            let pickerVc = GenYPickerViewController.instantiate(withType: .Date)
            pickerVc.picker(withDatePickerMode: .date, delegate: self)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController?.present(pickerVc, animated: true, completion: nil)
        }else if indexPath.row == 2{
            selectedIndex = 2
            let pickerVc = GenYPickerViewController.instantiate(withType: .Date)
            pickerVc.picker(withDatePickerMode: .time, delegate: self)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController?.present(pickerVc, animated: true, completion: nil)
        }else if indexPath.row == 3{
            selectedIndex = 3
            let aboutVC = AboutRouter.setupModule()
            aboutVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.navigationController?.present(aboutVC, animated: true, completion: nil)
        }else if indexPath.row == 4 {
            selectedIndex = 3
            let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
            alertVC.delegate = self
            alertVC.okButtonTitle = "YES"
            alertVC.bodyText = "Are you sure, You want to logout"
            alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.navigationController?.present(alertVC, animated: true, completion: nil)
        }
    }
}


extension ProfileViewController : GenYPickerDelegate {
    func didSelect(value: String, selectedIndex: Int, for picker: GenYPickerViewController){
        
    }
    func didSelect(date: Date, for picker: GenYPickerViewController){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        
//        let date = Date()
//        
//        let calendar = Calendar.current
//        let comp = calendar.dateComponents([.hour, .minute], from: date)
//        let hour = comp.hour
//        let minute = comp.minute
        
        print("\(date.localizedDescription)")
        
        if selectedIndex == 1{
            UserDefaults.standard.set(date, forKey: appDelegate.examDateKey)
            LoginViewController.setUpLocalNotificationForExamDate()
            self.tableView.reloadData()
        }else if selectedIndex == 2{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: date) // stri

            formatter.locale = Locale.current
            let yourDate = formatter.date(from: dateString)
            
            UserDefaults.standard.set(yourDate, forKey: appDelegate.studyTimeKey)
            LoginViewController.setUpLocalNotificationForStudyTime()
            self.tableView.reloadData()
        }
    }
    
    func UTCToLocal(UTCDateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Input Format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let UTCDate = dateFormatter.date(from: UTCDateString)
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss" // Output Format
        dateFormatter.timeZone = TimeZone.current
        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
        return UTCToCurrentFormat
    }
}

extension ProfileViewController : AlertViewControllerDelegate{
    func okButtonPressed(type:DialogType){
        PracticesDBManager.sharedInstance.deleteAllPracticesQuestionsInDatabase()
        MainListRouter.logout(navigation: self.navigationController!)
    }
    func cancelButtonPressed(type:DialogType){
        
    }
}
