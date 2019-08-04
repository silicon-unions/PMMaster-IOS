//
//  QuickQuestionViewControllerRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/29/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class QuickQuestionViewControllerRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> QuickQuestionViewControllerViewController {
        let viewController = UIStoryboard.loadViewController() as QuickQuestionViewControllerViewController
        let presenter = QuickQuestionViewControllerPresenter()
        let router = QuickQuestionViewControllerRouter()
        let interactor = QuickQuestionViewControllerInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension QuickQuestionViewControllerRouter: QuickQuestionViewControllerWireframe {
    // TODO: Implement wireframe methods
}
