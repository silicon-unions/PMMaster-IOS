//
//  ExamResultPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/11/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamResultPresenter {

    // MARK: Properties

    var view: ExamResultView?
    var router: ExamResultWireframe?
    var interactor: ExamResultUseCase?
}

extension ExamResultPresenter: ExamResultPresentation {
    // TODO: implement presentation methods
}

extension ExamResultPresenter: ExamResultInteractorOutput {
    // TODO: implement interactor output methods
}
