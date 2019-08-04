//
//  PracticeMainPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/28/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class PracticeMainPresenter {

    // MARK: Properties

    var view: PracticeMainView?
    var router: PracticeMainWireframe?
    var interactor: PracticeMainUseCase?
    
}

extension PracticeMainPresenter: PracticeMainPresentation {
    // TODO: implement presentation methods
}

extension PracticeMainPresenter: PracticeMainInteractorOutput {
    // TODO: implement interactor output methods
}
