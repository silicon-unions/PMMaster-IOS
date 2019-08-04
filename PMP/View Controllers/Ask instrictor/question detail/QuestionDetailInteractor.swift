//
//  QuestionDetailInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class QuestionDetailInteractor {

    // MARK: Properties

    weak var output: QuestionDetailInteractorOutput?
    
    
    
    
    func callSeenQuestion(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let askInstructorService  = AskInstructorService()
        askInstructorService.startSeenQuestion(params: params, completionHandler: handler)
    }
}

extension QuestionDetailInteractor: QuestionDetailUseCase {
    // TODO: Implement use case methods
}
