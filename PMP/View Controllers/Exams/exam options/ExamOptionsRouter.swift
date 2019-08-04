//
//  ExamOptionsRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/7/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamOptionsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ExamOptionsViewController {
        let viewController = UIStoryboard.loadViewController() as ExamOptionsViewController
        let presenter = ExamOptionsPresenter()
        let router = ExamOptionsRouter()
        let interactor = ExamOptionsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ExamOptionsRouter: ExamOptionsWireframe {
    // TODO: Implement wireframe methods
}
