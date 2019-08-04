//
//  ProfilePresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/18/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ProfilePresenter {

    // MARK: Properties

    var view: ProfileView?
    var router: ProfileWireframe?
    var interactor: ProfileUseCase?

    func callGetProfile(){
        let profileViewController = self.view as! ProfileViewController
        
        profileViewController.showSpinner()
        interactor = ProfileInteractor()
        (interactor as! ProfileInteractor).callGetProfile(handler: { (model, error) in
            if (model as! ProfileDataModel).success!{
                print(model!)
//                profileViewController.userNotes = (model as! NotesDataModel).userNotesArray!
                
//                profileViewController.tableView.reloadData()
                profileViewController.nameLabel.text = (model as! ProfileDataModel).name
                profileViewController.emailLabel.text = (model as! ProfileDataModel).email
                
            }else{
                (self.view as! ProfileViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            profileViewController.hideSpinner()
            
        })
    }
}

extension ProfilePresenter: ProfilePresentation {
    // TODO: implement presentation methods
}

extension ProfilePresenter: ProfileInteractorOutput {
    // TODO: implement interactor output methods
}
