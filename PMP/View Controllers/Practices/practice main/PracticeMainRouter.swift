//
//  PracticeMainRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/28/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class PracticeMainRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> PracticeMainViewController {
        let viewController = UIStoryboard.loadViewController() as PracticeMainViewController
        let presenter = PracticeMainPresenter()
        let router = PracticeMainRouter()
        let interactor = PracticeMainInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension PracticeMainRouter: PracticeMainWireframe {
    // TODO: Implement wireframe methods
}
