//
//  QuestionDetailPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class QuestionDetailPresenter {

    // MARK: Properties

    var view: QuestionDetailView?
    var router: QuestionDetailWireframe?
    var interactor: QuestionDetailUseCase?
    
    
    func callSeenQuestion(){
        let questionDetailViewController = self.view as! QuestionDetailViewController
        
        questionDetailViewController.showSpinner()
        interactor = QuestionDetailInteractor()
        (interactor as! QuestionDetailInteractor).callSeenQuestion(params:["question":"\(String(describing: questionDetailViewController.instructorQuestion?.questionId!))"], handler: { (model, error) in
            
            if (model as! AskInstructorDataModel).success!{
            }else{
            }
            
            questionDetailViewController.hideSpinner()
            
        })
    }
}

extension QuestionDetailPresenter: QuestionDetailPresentation {
    // TODO: implement presentation methods
}

extension QuestionDetailPresenter: QuestionDetailInteractorOutput {
    // TODO: implement interactor output methods
}
