//
//  MainViewInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class MainViewInteractor {

    // MARK: Properties

    weak var output: MainViewInteractorOutput?
    
    func callAllPracticeQuestions(params:[String : String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let practiceService  = PracticeService()
        practiceService.start(params: params, completionHandler: handler)
    }
    
    func callUserLevels(params:[String : String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let practiceService  = PracticeService()
        practiceService.startGetUserLevels(completionHandler: handler)
    }
    func callUpdateUserLevels(params:[String:Any],handler : @escaping (BaseModel?,Error?) -> Void) {
        let practiceService  = PracticeService()
        practiceService.startUpdateUserLevels(params: params, completionHandler: handler)
    }
}

extension MainViewInteractor: MainViewUseCase {
    // TODO: Implement use case methods
}
