//
//  ExamStatisticesPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/20/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamStatisticesPresenter {

    // MARK: Properties

    var view: ExamStatisticesView?
    var router: ExamStatisticesWireframe?
    var interactor: ExamStatisticesUseCase?
}

extension ExamStatisticesPresenter: ExamStatisticesPresentation {
    // TODO: implement presentation methods
}

extension ExamStatisticesPresenter: ExamStatisticesInteractorOutput {
    // TODO: implement interactor output methods
}
