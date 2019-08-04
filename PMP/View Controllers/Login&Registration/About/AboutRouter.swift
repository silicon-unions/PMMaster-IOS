//
//  AboutRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 9/20/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class AboutRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AboutViewController {
        let viewController = UIStoryboard.loadViewController() as AboutViewController
        let presenter = AboutPresenter()
        let router = AboutRouter()
        let interactor = AboutInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AboutRouter: AboutWireframe {
    // TODO: Implement wireframe methods
}
