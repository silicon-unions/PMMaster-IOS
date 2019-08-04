//
//  ProfilePasswordUpdatePresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ProfilePasswordUpdatePresenter {

    // MARK: Properties

    var view: ProfilePasswordUpdateView?
    var router: ProfilePasswordUpdateWireframe?
    var interactor: ProfileUpdateInteractor?
    
    var inputDataModels:  [InputSectionViewCell.InputSectionModel]?
    
    func prepareDataModels() -> [InputSectionViewCell.InputSectionModel]{
        
        inputDataModels?.removeAll()
        inputDataModels =  [InputSectionViewCell.InputSectionModel]()

        let passwordModel = InputSectionViewCell.InputSectionModel.init(titleString: "Password", textFieldPlaceHolder: "Enter your password", hintMsgString: "", errorMsgeString: "invalid password", regularExpression: "^[a-zA-Z0-9@#$*@!%^&{}<> ]{6,15}")
        
        let confirmPasswordModel = InputSectionViewCell.InputSectionModel.init(titleString: "Confirm Password", textFieldPlaceHolder: "re-enter your password", hintMsgString: "", errorMsgeString: "invalid password", regularExpression: "^[a-zA-Z0-9@#$*@!%^&{}<> ]{6,15}")
        
        inputDataModels?.append(passwordModel)
        inputDataModels?.append(confirmPasswordModel)
        
        return inputDataModels!
    }
    
    func callUpdateProfile(params:[String:String]){
        let profilePasswordUpdateViewController = self.view as! ProfilePasswordUpdateViewController
        
        profilePasswordUpdateViewController.showSpinner()
        interactor = ProfileUpdateInteractor()
        (interactor)?.callUpdateProfile(params: params, handler: { (model, error) in
            if (model as! AppBaseModel).success!{
                print(model!)
                (self.view as! ProfilePasswordUpdateViewController).showDefaultAlert(message: (model as! AppBaseModel).reason!,popView: true)
            }else{
                (self.view as! ProfilePasswordUpdateViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            profilePasswordUpdateViewController.hideSpinner()
            
        })
    }
}

extension ProfilePasswordUpdatePresenter: ProfilePasswordUpdatePresentation {
    // TODO: implement presentation methods
}

extension ProfilePasswordUpdatePresenter: ProfilePasswordUpdateInteractorOutput {
    // TODO: implement interactor output methods
}
