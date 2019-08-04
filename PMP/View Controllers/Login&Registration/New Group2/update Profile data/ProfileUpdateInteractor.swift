//
//  ProfileUpdateInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ProfileUpdateInteractor {

    // MARK: Properties

    weak var output: ProfileUpdateInteractorOutput?
    
    func callUpdateProfile(params: [String:String], handler : @escaping (BaseModel?,Error?) -> Void) {
        let profileService  = ProfileService()
        profileService.startUpdateProfile(params:params,completionHandler: handler)
    }
}

extension ProfileUpdateInteractor: ProfileUpdateUseCase {
    // TODO: Implement use case methods
}
