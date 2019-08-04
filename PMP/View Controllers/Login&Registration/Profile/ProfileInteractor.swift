//
//  ProfileInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/18/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ProfileInteractor {

    // MARK: Properties

    weak var output: ProfileInteractorOutput?
    
    func callGetProfile(handler : @escaping (BaseModel?,Error?) -> Void) {
        let profileService  = ProfileService()
        profileService.start(completionHandler: handler)
    }
}

extension ProfileInteractor: ProfileUseCase {
    // TODO: Implement use case methods
}
