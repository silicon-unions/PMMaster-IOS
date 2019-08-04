//
//  AddQuestionInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class AddQuestionInteractor {

    // MARK: Properties

    weak var output: AddQuestionInteractorOutput?
    
    func addQuestionCall(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let askInstructorService  = AskInstructorService()
        askInstructorService.startAddQuestion(params: params, completionHandler: handler)
    }
}

extension AddQuestionInteractor: AddQuestionUseCase {
    // TODO: Implement use case methods
}
