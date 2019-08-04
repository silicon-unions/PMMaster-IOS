//
//  AddQuestionRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class AddQuestionRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddQuestionViewController {
        let viewController = UIStoryboard.loadViewController() as AddQuestionViewController
        let presenter = AddQuestionPresenter()
        let router = AddQuestionRouter()
        let interactor = AddQuestionInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddQuestionRouter: AddQuestionWireframe {
    // TODO: Implement wireframe methods
}
