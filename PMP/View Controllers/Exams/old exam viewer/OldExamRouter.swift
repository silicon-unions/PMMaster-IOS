//
//  OldExamRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/24/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class OldExamRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> OldExamViewController {
        let viewController = UIStoryboard.loadViewController() as OldExamViewController
        let presenter = OldExamPresenter()
        let router = OldExamRouter()
        let interactor = OldExamInteractor()

//        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension OldExamRouter: OldExamWireframe {
    // TODO: Implement wireframe methods
}
