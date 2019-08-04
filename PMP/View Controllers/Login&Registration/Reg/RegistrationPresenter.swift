//
//  RegistrationPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class RegistrationPresenter {

    // MARK: Properties

    var view: RegistrationView?
    var router: RegistrationWireframe?
    var interactor: RegistrationUseCase? = RegistrationInteractor()
    
    var inputDataModels:  [InputSectionViewCell.InputSectionModel]?
    
    func prepareDataModels() -> [InputSectionViewCell.InputSectionModel]{
        
        inputDataModels?.removeAll()
        inputDataModels =  [InputSectionViewCell.InputSectionModel]()
        
        let nameModel = InputSectionViewCell.InputSectionModel.init(titleString: "Full Name", textFieldPlaceHolder: "Enter your name", hintMsgString: "", errorMsgeString: "invalid name format" , regularExpression: "[A-Z0-9a-z]{2,20}")
        
        let passwordModel = InputSectionViewCell.InputSectionModel.init(titleString: "Password", textFieldPlaceHolder: "Enter your password", hintMsgString: "", errorMsgeString: "invalid password", regularExpression: "^[a-zA-Z0-9@#$*@!%^&{}<> ]{8,15}")
        
        let confirmPasswordModel = InputSectionViewCell.InputSectionModel.init(titleString: "Confirm Password", textFieldPlaceHolder: "re-enter your password", hintMsgString: "", errorMsgeString: "invalid password", regularExpression: "^[a-zA-Z0-9@#$*@!%^&{}<> ]{8,15}")
        
        let emailModel = InputSectionViewCell.InputSectionModel.init(titleString: "Email", textFieldPlaceHolder: "Enter your email", hintMsgString: "", errorMsgeString: "invalid email address" , regularExpression: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
        
        inputDataModels?.append(nameModel)
        inputDataModels?.append(passwordModel)
        inputDataModels?.append(confirmPasswordModel)
        inputDataModels?.append(emailModel)
        
        return inputDataModels!
    }
    
    func register(){
        let registrationView = self.view as! RegistrationViewController
        
        (self.view as! RegistrationViewController).showSpinner()
        interactor?.register(params: ["name" : registrationView.dataForCellAtIndex(index: 0),"email":registrationView.dataForCellAtIndex(index: 3),"password" : registrationView.dataForCellAtIndex(index: 2)], handler: { (model, error) in
        
            if (model as! RegistrationModel).success!{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.authenToken = (model as! RegistrationModel).apiToken!
                registrationView.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: true)
            }else{
                (self.view as! RegistrationViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            registrationView.hideSpinner()
            
        })
    }
    
    func registerViaFacebook(params:[String:String]){
        let registrationView = self.view as! RegistrationViewController
        
        (self.view as! RegistrationViewController).showSpinner()
        (interactor as! RegistrationInteractor).registerWithFB(params: params, handler: { (model, error) in
            
            if (model as! RegistrationModel).success!{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.authenToken = (model as! RegistrationModel).apiToken!
                registrationView.navigationController?.pushViewController(MainViewRouter.setupModule(), animated: true)
            }else{
                (self.view as! RegistrationViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            registrationView.hideSpinner()
            
        })
    }
}

extension RegistrationPresenter: RegistrationPresentation {
    // TODO: implement presentation methods
}

extension RegistrationPresenter: RegistrationInteractorOutput {
    // TODO: implement interactor output methods
}
