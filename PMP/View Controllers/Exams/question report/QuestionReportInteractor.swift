//
//  QuestionReportInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/13/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class QuestionReportInteractor {

    // MARK: Properties

    weak var output: QuestionReportInteractorOutput?
    
    func callReport(params:[String : String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let examService  = ExamService()
        examService.startReport(params: params, completionHandler: handler)
    }
}

extension QuestionReportInteractor: QuestionReportUseCase {
    // TODO: Implement use case methods
}
