//
//  AboutPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 9/20/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class AboutPresenter {

    // MARK: Properties

    var view: AboutView?
    var router: AboutWireframe?
    var interactor: AboutUseCase?
}

extension AboutPresenter: AboutPresentation {
    // TODO: implement presentation methods
}

extension AboutPresenter: AboutInteractorOutput {
    // TODO: implement interactor output methods
}
