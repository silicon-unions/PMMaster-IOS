//
//  AskInstructorInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class AskInstructorInteractor {

    // MARK: Properties

    weak var output: AskInstructorInteractorOutput?
    
    func askInstructorCall(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let askInstructorService  = AskInstructorService()
        askInstructorService.start(params: params, completionHandler: handler)
    }
    
    func deleteQuestionCall(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let askInstructorService  = AskInstructorService()
        askInstructorService.startDeleteQuestion(params: params, completionHandler: handler)
    }
}

extension AskInstructorInteractor: AskInstructorUseCase {
    // TODO: Implement use case methods
}
