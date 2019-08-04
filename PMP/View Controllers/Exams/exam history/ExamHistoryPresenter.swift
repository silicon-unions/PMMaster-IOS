//
//  ExamHistoryPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamHistoryPresenter {

    // MARK: Properties

    var view: ExamHistoryView?
    var router: ExamHistoryWireframe?
    var interactor: ExamHistoryUseCase?
}

extension ExamHistoryPresenter: ExamHistoryPresentation {
    // TODO: implement presentation methods
}

extension ExamHistoryPresenter: ExamHistoryInteractorOutput {
    // TODO: implement interactor output methods
}
