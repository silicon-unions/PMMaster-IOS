//
//  PracticeService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/29/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class PracticeService {
    func start(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.practiceQuestions,httpMethod: .post,bodyParams:params) { (response, error) in
                if response != nil {
                    let responseModel = PracticeMainDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    completionHandler(nil , error)
                }
        }
        forgotPasswordRequest.send()
    }
    
    func startUpdateUserLevels(params: [String:Any], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.updateUserLevels,httpMethod: .post,bodyParams:params) { (response, error) in
                if response != nil {
                    let responseModel = AppBaseModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    completionHandler(nil , error)
                }
        }
        forgotPasswordRequest.send()
    }
    
    func startGetUserLevels(completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.userLevels,httpMethod: .get,bodyParams:[:]) { (response, error) in
                if response != nil {
                    let responseModel = PracticeLevelsDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    completionHandler(nil , error)
                }
        }
        forgotPasswordRequest.sendGet()
    }
}
