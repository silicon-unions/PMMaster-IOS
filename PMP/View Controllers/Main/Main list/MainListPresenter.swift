//
//  MainListPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class MainListPresenter {

    // MARK: Properties

    var view: MainListView?
    var router: MainListWireframe?
    var interactor: MainListUseCase?
}

extension MainListPresenter: MainListPresentation {
    // TODO: implement presentation methods
}

extension MainListPresenter: MainListInteractorOutput {
    // TODO: implement interactor output methods
}
