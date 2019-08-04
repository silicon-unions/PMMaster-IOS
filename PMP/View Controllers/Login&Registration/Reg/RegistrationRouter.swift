//
//  RegistrationRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class RegistrationRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> RegistrationViewController {
        let viewController = UIStoryboard.loadViewController() as RegistrationViewController
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()
        let interactor = RegistrationInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension RegistrationRouter: RegistrationWireframe {
    // TODO: Implement wireframe methods
}
