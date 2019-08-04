//
//  ProfileUpdateViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ProfileUpdateViewController: BaseViewController {

    // MARK: Properties

    var presenter: ProfileUpdatePresentation?
    
    @IBOutlet weak var submitView: SubmitButtonView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameInputSectionView: InputSectionView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let image = appDelegate.profileImage{
            self.profileImageView.image = image
        }else{
            self.downloadProfilePic()
        }
        presenter = ProfileUpdatePresenter()
        (presenter as! ProfileUpdatePresenter).view = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        submitView.submitButton.addTarget(self, action: #selector(updatePressed), for: UIControlEvents.touchUpInside)
        submitView.submitButton.setTitle("UPDATE", for: .normal)
        nameInputSectionView.inputTextField.delegate = self
        nameInputSectionView.inputTextField.placeholder = "Name"
        
        submitView.submitButton.backgroundColor = UIColor.darkGray
        submitView.submitButton.setTitleColor(UIColor.lightGray, for: .normal)
        submitView.isUserInteractionEnabled = false
    }
    
    @objc func updatePressed(){
        (presenter as! ProfileUpdatePresenter).callUpdateProfile(params: ["name":self.nameInputSectionView.inputTextField.text!])
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.navigationController?.pushViewController(ProfilePasswordUpdateRouter.setupModule(), animated: true)
    }
    
    @IBAction func selectImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        dismiss(animated:true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage // #imageLiteral(resourceName: "test profile image")//info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgData: NSData = NSData(data: UIImageJPEGRepresentation((image), 1)!)
        let imageSize: Int = imgData.length
        
        if imageSize <= 2000000{
            self.upload(profilePic: image)
//            profileImageView.image = image
        }else{
            self.showDefaultAlert(message: "Please select image less than 2MB", popView: false)
//            self.upload(profilePic: image)
        }
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
                    self.profileImageView.image = profilePic
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.profileImage = profilePic
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
                    self.profileImageView.image = image
                }else{
                    // set placeHolder
                }
                
        }
        debugPrint(request)
    }
}


extension ProfileUpdateViewController: ProfileUpdateView {
    // TODO: implement view output methods
}
extension ProfileUpdateViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Profile"
    }
}

extension ProfileUpdateViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.count > 2{
            submitView.submitButton.backgroundColor = UIColor.PMPYellow
            submitView.submitButton.setTitleColor(UIColor.white, for: .normal)
            submitView.isUserInteractionEnabled = true
        }else{
            submitView.submitButton.backgroundColor = UIColor.lightGray
            submitView.submitButton.setTitleColor(UIColor.darkGray, for: .normal)
            submitView.isUserInteractionEnabled = false
        }
    }
}

extension ProfileUpdateViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
}
