//
//  ExamQuestionsListPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/11/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamQuestionsListPresenter {

    // MARK: Properties

    var view: ExamQuestionsListView?
    var router: ExamQuestionsListWireframe?
    var interactor: ExamQuestionsListUseCase?
}

extension ExamQuestionsListPresenter: ExamQuestionsListPresentation {
    // TODO: implement presentation methods
}

extension ExamQuestionsListPresenter: ExamQuestionsListInteractorOutput {
    // TODO: implement interactor output methods
}
