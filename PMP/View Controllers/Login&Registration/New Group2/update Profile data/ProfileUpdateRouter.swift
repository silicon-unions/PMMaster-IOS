//
//  ProfileUpdateRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ProfileUpdateRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ProfileUpdateViewController {
        let viewController = UIStoryboard.loadViewController() as ProfileUpdateViewController
        let presenter = ProfileUpdatePresenter()
        let router = ProfileUpdateRouter()
        let interactor = ProfileUpdateInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ProfileUpdateRouter: ProfileUpdateWireframe {
    // TODO: Implement wireframe methods
}
