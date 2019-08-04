//
//  AddQuestionPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class AddQuestionPresenter {

    // MARK: Properties

    var view: AddQuestionView?
    var router: AddQuestionWireframe?
    var interactor: AddQuestionUseCase?
    
    
    func callAddQuestion(){
        let addQuestionViewController = self.view as! AddQuestionViewController
        
        addQuestionViewController.showSpinner()
        interactor = AddQuestionInteractor()
        (interactor as! AddQuestionInteractor).addQuestionCall(params:["question":addQuestionViewController.textView.text], handler: { (model, error) in
            
            if error != nil {
//                if let errorMsg = error?.localizedDescription {
//                    addQuestionViewController.showDefaultAlert(message: errorMsg, popView: false)
//                }else{
//                    addQuestionViewController.showDefaultAlert(message: "General Error", popView: false)
//                }
                addQuestionViewController.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: .askInstrutorListCallNotification, object: nil)
                
                addQuestionViewController.hideSpinner()
                return
            }
            if let success = (model as? AskInstructorDataModel)?.success{
                if success{
                    addQuestionViewController.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: .askInstrutorListCallNotification, object: nil)
                }else{
                    addQuestionViewController.showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
                }
            }else{
                addQuestionViewController.showDefaultAlert(message: "General Error", popView: false)
            }
            
            addQuestionViewController.hideSpinner()
            
        })
    }
}

extension AddQuestionPresenter: AddQuestionPresentation {
    // TODO: implement presentation methods
}

extension AddQuestionPresenter: AddQuestionInteractorOutput {
    // TODO: implement interactor output methods
}
