//
//  ForgotPasswordInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ForgotPasswordInteractor {

    // MARK: Properties

    weak var output: ForgotPasswordInteractorOutput?
    
    func callForgotPassword(email :String,handler : @escaping (BaseModel?,Error?) -> Void) {
        let forgotPasswordService  = ForgotPasswordService()
        forgotPasswordService.start(params: email, completionHandler: handler)
    }
}


extension ForgotPasswordInteractor: ForgotPasswordUseCase {
    // TODO: Implement use case methods
}
