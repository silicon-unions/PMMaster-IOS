//
//  AskInstructorPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class AskInstructorPresenter {

    // MARK: Properties

    var view: AskInstructorView?
    var router: AskInstructorWireframe?
    var interactor: AskInstructorUseCase?
    
    func callAskInstrucor(){
        let askInstructorView = self.view as! AskInstructorViewController
        
        askInstructorView.showSpinner()
        interactor = AskInstructorInteractor()
        interactor?.askInstructorCall(params:[:], handler: { (model, error) in
            
            if error != nil {
                if let errorMsg = error?.localizedDescription {
                    askInstructorView.showDefaultAlert(message: errorMsg, popView: false)
                }else{
                    askInstructorView.showDefaultAlert(message: "General Error", popView: false)
                }
                askInstructorView.hideSpinner()
                return
            }
            
            askInstructorView.hideSpinner()
            if let success = (model as! AskInstructorDataModel).success{
                if success{
                askInstructorView.instructorQuestions = (model as! AskInstructorDataModel).instructorQuestionsArray!
                askInstructorView.tableView.reloadData()
                print(model!)
                }
                
            }else{
                (self.view as! RegistrationViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            askInstructorView.hideSpinner()
            
        })
    }
    
    func calldeleteQuestion(withID:Int){
        let askInstructorView = self.view as! AskInstructorViewController
        
        askInstructorView.showSpinner()
        interactor = AskInstructorInteractor()
        (interactor as! AskInstructorInteractor).deleteQuestionCall(params:["id":"\(withID)"], handler: { (model, error) in
            
            if (model as! AskInstructorDataModel).success!{
                askInstructorView.callAskInstrutorList()
                askInstructorView.showDefaultAlert(message: (model as! AskInstructorDataModel).reason!, popView: false)
                print(model!)
                
            }else{
                (self.view as! RegistrationViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            askInstructorView.hideSpinner()
            
        })
    }
}

extension AskInstructorPresenter: AskInstructorPresentation {
    // TODO: implement presentation methods
}

extension AskInstructorPresenter: AskInstructorInteractorOutput {
    // TODO: implement interactor output methods
}
