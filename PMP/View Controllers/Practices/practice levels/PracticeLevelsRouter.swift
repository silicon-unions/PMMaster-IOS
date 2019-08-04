//
//  PracticeLevelsRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/28/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class PracticeLevelsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> PracticeLevelsViewController {
        let viewController = UIStoryboard.loadViewController() as PracticeLevelsViewController
        let presenter = PracticeLevelsPresenter()
        let router = PracticeLevelsRouter()
        let interactor = PracticeLevelsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension PracticeLevelsRouter: PracticeLevelsWireframe {
    // TODO: Implement wireframe methods
}
