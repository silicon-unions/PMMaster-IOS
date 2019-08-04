//
//  ExamQuestionsListRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/11/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamQuestionsListRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ExamQuestionsListViewController {
        let viewController = UIStoryboard.loadViewController() as ExamQuestionsListViewController
        let presenter = ExamQuestionsListPresenter()
        let router = ExamQuestionsListRouter()
        let interactor = ExamQuestionsListInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ExamQuestionsListRouter: ExamQuestionsListWireframe {
    // TODO: Implement wireframe methods
}
