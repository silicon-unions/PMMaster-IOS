//
//  PracticeQuestionRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/30/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class PracticeQuestionRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> PracticeQuestionViewController {
        let viewController = UIStoryboard.loadViewController() as PracticeQuestionViewController
        let presenter = PracticeQuestionPresenter()
        let router = PracticeQuestionRouter()
        let interactor = PracticeQuestionInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension PracticeQuestionRouter: PracticeQuestionWireframe {
    // TODO: Implement wireframe methods
}
