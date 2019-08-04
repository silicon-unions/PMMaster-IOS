//
//  QuestionReportPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/13/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class QuestionReportPresenter {

    // MARK: Properties

    var view: QuestionReportView?
    var router: QuestionReportWireframe?
    var interactor: QuestionReportUseCase?
    
    
    func callExam(){
        let questionReportViewController = self.view as! QuestionReportViewController
        
        questionReportViewController.showSpinner()
        interactor = QuestionReportInteractor()
        var id : Int?
        if let pracQues = questionReportViewController.practiceQuestion{
            id = pracQues.questionId
        }else{
            id = (questionReportViewController.question?.questionId)!
        }
        (interactor as! QuestionReportInteractor).callReport(params: ["question_id":"\(id!)","message" : questionReportViewController.textView.text],handler: { (model, error) in
            if error != nil {
                (self.view as! QuestionReportViewController).showDefaultAlert(message: (error?.localizedDescription)!, popView: true)
            }
            else if (model as! AppBaseModel).success!{
                (self.view as! QuestionReportViewController).showDefaultAlert(message: (model as! AppBaseModel).reason!,dismissView: true)
//                questionReportViewController.dismiss(animated: true, completion: nil)
            }else{
                (self.view as! QuestionReportViewController).showDefaultAlert(message: (model as! AppBaseModel).reason!,popView: false)
            }
            
            questionReportViewController.hideSpinner()
            
        })
    }
}

extension QuestionReportPresenter: QuestionReportPresentation {
    // TODO: implement presentation methods
}

extension QuestionReportPresenter: QuestionReportInteractorOutput {
    // TODO: implement interactor output methods
}
