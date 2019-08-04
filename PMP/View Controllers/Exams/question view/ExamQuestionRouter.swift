//
//  ExamQuestionRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamQuestionRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ExamQuestionViewController {
        let viewController = UIStoryboard.loadViewController() as ExamQuestionViewController
        let presenter = ExamQuestionPresenter()
        let router = ExamQuestionRouter()
        let interactor = ExamQuestionInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ExamQuestionRouter: ExamQuestionWireframe {
    // TODO: Implement wireframe methods
}
