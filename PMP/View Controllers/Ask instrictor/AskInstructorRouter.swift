//
//  AskInstructorRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class AskInstructorRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AskInstructorViewController {
        let viewController = UIStoryboard.loadViewController() as AskInstructorViewController
        let presenter = AskInstructorPresenter()
        let router = AskInstructorRouter()
        let interactor = AskInstructorInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    
    static func presentAddQuestion(view : UIViewController){
        let addQuestionVC = AddQuestionRouter.setupModule()
        addQuestionVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(addQuestionVC, animated: true, completion: nil)
    }
    
    static func presentQuestionDetail(view : UIViewController , question : InstructorQuestion){
        let questionDetailVC = QuestionDetailRouter.setupModule()
        questionDetailVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        questionDetailVC.instructorQuestion = question
        view.navigationController?.present(questionDetailVC, animated: true, completion: nil)
    }
}

extension AskInstructorRouter: AskInstructorWireframe {
    // TODO: Implement wireframe methods
}
