//
//  ExamQuestionInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamQuestionInteractor {

    // MARK: Properties

    weak var output: ExamQuestionInteractorOutput?
    
    func callExam(params:[String : String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let examService  = ExamService()
        examService.start(params: params, completionHandler: handler)
    }
}

extension ExamQuestionInteractor: ExamQuestionUseCase {
    // TODO: Implement use case methods
}
