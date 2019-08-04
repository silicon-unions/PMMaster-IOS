//
//  ProfilePasswordUpdateRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ProfilePasswordUpdateRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ProfilePasswordUpdateViewController {
        let viewController = UIStoryboard.loadViewController() as ProfilePasswordUpdateViewController
        let presenter = ProfilePasswordUpdatePresenter()
        let router = ProfilePasswordUpdateRouter()
        let interactor = ProfileUpdateInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

//        interactor.output = presenter

        return viewController
    }
}

extension ProfilePasswordUpdateRouter: ProfilePasswordUpdateWireframe {
    // TODO: Implement wireframe methods
}
