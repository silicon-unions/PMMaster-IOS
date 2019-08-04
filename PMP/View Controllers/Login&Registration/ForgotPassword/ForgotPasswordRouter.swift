//
//  ForgotPasswordRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ForgotPasswordViewController {
        let viewController = UIStoryboard.loadViewController() as ForgotPasswordViewController
        let presenter = ForgotPasswordPresenter()
        let router = ForgotPasswordRouter()
        let interactor = ForgotPasswordInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    
    func pop() {
        (self.view as! ForgotPasswordViewController).navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordRouter: ForgotPasswordWireframe {
    // TODO: Implement wireframe methods
}
