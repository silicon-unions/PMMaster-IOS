//
//  QuestionDetailRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class QuestionDetailRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> QuestionDetailViewController {
        let viewController = UIStoryboard.loadViewController() as QuestionDetailViewController
        let presenter = QuestionDetailPresenter()
        let router = QuestionDetailRouter()
        let interactor = QuestionDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension QuestionDetailRouter: QuestionDetailWireframe {
    // TODO: Implement wireframe methods
}
