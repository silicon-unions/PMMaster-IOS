//
//  QuickQuestionsStatisticesRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 9/16/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class QuickQuestionsStatisticesRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> QuickQuestionsStatisticesViewController {
        let viewController = UIStoryboard.loadViewController() as QuickQuestionsStatisticesViewController
        let presenter = QuickQuestionsStatisticesPresenter()
        let router = QuickQuestionsStatisticesRouter()
        let interactor = QuickQuestionsStatisticesInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension QuickQuestionsStatisticesRouter: QuickQuestionsStatisticesWireframe {
    // TODO: Implement wireframe methods
}
