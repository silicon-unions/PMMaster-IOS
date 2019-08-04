//
//  ForgotPasswordContract.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

protocol ForgotPasswordView: BaseView {
    // TODO: Declare view methods
}

protocol ForgotPasswordPresentation: class {
    func prepareViewModel() -> [InputSectionViewCell.InputSectionModel]
    func submitForgotPassword(email:String)
}

protocol ForgotPasswordUseCase: class {
    // TODO: Declare use case methods
    func callForgotPassword(email :String,handler : @escaping (BaseModel?,Error?) -> Void) 
}

protocol ForgotPasswordInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol ForgotPasswordWireframe: class {
    // TODO: Declare wireframe methods
}
