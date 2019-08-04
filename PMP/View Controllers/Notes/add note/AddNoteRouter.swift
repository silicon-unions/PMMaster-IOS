//
//  AddNoteRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/26/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class AddNoteRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddNoteViewController {
        let viewController = UIStoryboard.loadViewController() as AddNoteViewController
        let presenter = AddNotePresenter()
        let router = AddNoteRouter()
        let interactor = AddNoteInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    

}

extension AddNoteRouter: AddNoteWireframe {
    // TODO: Implement wireframe methods
}
