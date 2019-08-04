//
//  RegistrationDataModelRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class RegistrationDataModelRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> RegistrationDataModelViewController {
        let viewController = UIStoryboard.loadViewController() as RegistrationDataModelViewController
        let presenter = RegistrationDataModelPresenter()
        let router = RegistrationDataModelRouter()
        let interactor = RegistrationDataModelInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension RegistrationDataModelRouter: RegistrationDataModelWireframe {
    // TODO: Implement wireframe methods
}
