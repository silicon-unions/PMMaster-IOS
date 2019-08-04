//
//  DailyTransactionsRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/31/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class DailyTransactionsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DailyTransactionsViewController {
        let viewController = UIStoryboard.loadViewController() as DailyTransactionsViewController
        let presenter = DailyTransactionsPresenter()
        let router = DailyTransactionsRouter()
        let interactor = DailyTransactionsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DailyTransactionsRouter: DailyTransactionsWireframe {
    // TODO: Implement wireframe methods
}
