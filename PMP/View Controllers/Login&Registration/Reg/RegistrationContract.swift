//
//  RegistrationContract.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

protocol RegistrationView: BaseView {
    // TODO: Declare view methods
}

protocol RegistrationPresentation: class {
    // TODO: Declare presentation methods
    func prepareDataModels() -> [InputSectionViewCell.InputSectionModel]
    func register()
}

protocol RegistrationUseCase: class {
    // TODO: Declare use case methods
    func register(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void)
}

protocol RegistrationInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol RegistrationWireframe: class {
    // TODO: Declare wireframe methods
}
