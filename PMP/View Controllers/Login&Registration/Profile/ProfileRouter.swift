//
//  ProfileRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/18/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ProfileViewController {
        let viewController = UIStoryboard.loadViewController() as ProfileViewController
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        let interactor = ProfileInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ProfileRouter: ProfileWireframe {
    // TODO: Implement wireframe methods
}
