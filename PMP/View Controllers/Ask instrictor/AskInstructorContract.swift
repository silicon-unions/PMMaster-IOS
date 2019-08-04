//
//  AskInstructorContract.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

protocol AskInstructorView: BaseView {
    // TODO: Declare view methods
}

protocol AskInstructorPresentation: class {
    // TODO: Declare presentation methods
}

protocol AskInstructorUseCase: class {
    func askInstructorCall(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void)
}

protocol AskInstructorInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol AskInstructorWireframe: class {
    // TODO: Declare wireframe methods
}
