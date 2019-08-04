//
//  OldExamPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/24/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class OldExamPresenter {

    // MARK: Properties

    var view: OldExamView?
    var router: OldExamWireframe?
    var interactor: OldExamUseCase?
}

extension OldExamPresenter: OldExamPresentation {
    // TODO: implement presentation methods
}

extension OldExamPresenter: OldExamInteractorOutput {
    // TODO: implement interactor output methods
}
