//
//  ExamHistoryRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamHistoryRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ExamHistoryViewController {
        let viewController = UIStoryboard.loadViewController() as ExamHistoryViewController
        let presenter = ExamHistoryPresenter()
        let router = ExamHistoryRouter()
        let interactor = ExamHistoryInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ExamHistoryRouter: ExamHistoryWireframe {
    // TODO: Implement wireframe methods
}
