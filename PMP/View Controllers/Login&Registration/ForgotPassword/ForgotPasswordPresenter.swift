//
//  ForgotPasswordPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ForgotPasswordPresenter {

    // MARK: Properties

    var inputDataModels:  [InputSectionViewCell.InputSectionModel]!
    
    var view: ForgotPasswordView?
    var router: ForgotPasswordWireframe?
    var interactor: ForgotPasswordUseCase?
    
    func prepareViewModel() -> [InputSectionViewCell.InputSectionModel]{
        inputDataModels?.removeAll()
        inputDataModels =  [InputSectionViewCell.InputSectionModel]()
        
        let emailModel = InputSectionViewCell.InputSectionModel.init(titleString: "Email", textFieldPlaceHolder: "Enter your email", hintMsgString: "", errorMsgeString: "invalid email address" , regularExpression: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
        inputDataModels?.append(emailModel)
        return inputDataModels!
    }
    
    func submitForgotPassword(email:String) {
        interactor = ForgotPasswordInteractor()
        (self.view as! ForgotPasswordViewController).showSpinner()
        interactor?.callForgotPassword(email: email, handler: { (model, error) in
            print(model as! ForgotPasswordModel)
            
            if (model as! ForgotPasswordModel).success!{
                (self.view as! ForgotPasswordViewController).showDefaultAlert(message: (model as! ForgotPasswordModel).message!,popView: true)
            }else{
                (self.view as! ForgotPasswordViewController).showDefaultAlert(message: (model as! ForgotPasswordModel).reason!,popView: true)
            }
            
            
            (self.view as! ForgotPasswordViewController).hideSpinner()
        })
    }
    
}





extension ForgotPasswordPresenter: ForgotPasswordPresentation {
    // TODO: implement presentation methods
}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutput {
    // TODO: implement interactor output methods
}
