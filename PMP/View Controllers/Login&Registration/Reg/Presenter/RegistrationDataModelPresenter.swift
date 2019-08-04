//
//  RegistrationDataModelPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class RegistrationDataModelPresenter {

    // MARK: Properties

    var view: RegistrationDataModelView?
    var router: RegistrationDataModelWireframe?
    var interactor: RegistrationDataModelUseCase?
}

extension RegistrationDataModelPresenter: RegistrationDataModelPresentation {
    // TODO: implement presentation methods
}

extension RegistrationDataModelPresenter: RegistrationDataModelInteractorOutput {
    // TODO: implement interactor output methods
}
