//
//  LandingRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/15/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class LandingRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> LandingViewController {
        let viewController = UIStoryboard.loadViewController() as LandingViewController
        let presenter = LandingPresenter()
        let router = LandingRouter()
        let interactor = LandingInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension LandingRouter: LandingWireframe {
    // TODO: Implement wireframe methods
}
