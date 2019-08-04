//
//  LandingPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/15/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class LandingPresenter {

    // MARK: Properties

    var view: LandingView?
    var router: LandingWireframe?
    var interactor: LandingUseCase?
}

extension LandingPresenter: LandingPresentation {
    // TODO: implement presentation methods
}

extension LandingPresenter: LandingInteractorOutput {
    // TODO: implement interactor output methods
}
