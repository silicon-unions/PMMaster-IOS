//
//  DailyTransactionsPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/31/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class DailyTransactionsPresenter {

    // MARK: Properties

    var view: DailyTransactionsView?
    var router: DailyTransactionsWireframe?
    var interactor: DailyTransactionsUseCase?
}

extension DailyTransactionsPresenter: DailyTransactionsPresentation {
    // TODO: implement presentation methods
}

extension DailyTransactionsPresenter: DailyTransactionsInteractorOutput {
    // TODO: implement interactor output methods
}
