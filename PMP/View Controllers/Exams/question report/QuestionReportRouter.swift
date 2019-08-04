//
//  QuestionReportRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/13/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class QuestionReportRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> QuestionReportViewController {
        let viewController = UIStoryboard.loadViewController() as QuestionReportViewController
        let presenter = QuestionReportPresenter()
        let router = QuestionReportRouter()
        let interactor = QuestionReportInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension QuestionReportRouter: QuestionReportWireframe {
    // TODO: Implement wireframe methods
}
