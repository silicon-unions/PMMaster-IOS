//
//  ProfileUpdatePresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ProfileUpdatePresenter {

    // MARK: Properties

    var view: ProfileUpdateView?
    var router: ProfileUpdateWireframe?
    var interactor: ProfileUpdateUseCase?
    
    func callUpdateProfile(params:[String:String]){
        let profileUpdateViewController = self.view as! ProfileUpdateViewController
        
        profileUpdateViewController.showSpinner()
        interactor = ProfileUpdateInteractor()
        (interactor as! ProfileUpdateInteractor).callUpdateProfile(params: params, handler: { (model, error) in
            if (model as! AppBaseModel).success!{
                print(model!)
                (self.view as! ProfileUpdateViewController).showDefaultAlert(message: (model as! AppBaseModel).reason!,popView: true)
            }else{
                (self.view as! ProfileViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            profileUpdateViewController.hideSpinner()
            
        })
    }
}

extension ProfileUpdatePresenter: ProfileUpdatePresentation {
    // TODO: implement presentation methods
}

extension ProfileUpdatePresenter: ProfileUpdateInteractorOutput {
    // TODO: implement interactor output methods
}
