//
//  RegistrationInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import Gloss

class RegistrationInteractor {

    // MARK: Properties

    weak var output: RegistrationInteractorOutput?
    
    func register(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let registrationService  = RegistrationService()
        registrationService.start(params: params, completionHandler: handler)
    }
    
    func registerWithFB(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let registrationService  = RegistrationService()
        registrationService.startWithFB(params: params, completionHandler: handler)
    }
}

extension RegistrationInteractor: RegistrationUseCase {
    // TODO: Implement use case methods
}
