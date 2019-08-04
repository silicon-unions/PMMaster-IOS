//
//  ExamStatisticesRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/20/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamStatisticesRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ExamStatisticesViewController {
        let viewController = UIStoryboard.loadViewController() as ExamStatisticesViewController
        let presenter = ExamStatisticesPresenter()
        let router = ExamStatisticesRouter()
        let interactor = ExamStatisticesInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ExamStatisticesRouter: ExamStatisticesWireframe {
    // TODO: Implement wireframe methods
}
