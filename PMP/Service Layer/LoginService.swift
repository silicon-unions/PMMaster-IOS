//
//  LoginService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class LoginService{
    struct LoginModel {
        var userName: String
        var password: String
    }
    
    func start(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let loginRequest =
        BaseRequest.init(url: URLs.Path.login, bodyParams:params) { (response, error) in
            if response != nil {
                let responseModel = LoginResponseModel.init(json: response!)
                completionHandler(responseModel , nil)
            } else {
//                let errorModel = BEError.init(json: error )
                completionHandler(nil , error)
            }
        }
        loginRequest.send()
    }
    
    func startwithFB(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let loginRequest =
            BaseRequest.init(url: URLs.Path.loginWithFB, bodyParams:params) { (response, error) in
                if response != nil {
                    let responseModel = LoginResponseModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    //                let errorModel = BEError.init(json: error )
                    completionHandler(nil , error)
                }
        }
        loginRequest.send()
    }
    
    func startwithLinkedIn(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let loginRequest =
            BaseRequest.init(url: URLs.Path.loginWithLinkedIn, bodyParams:params) { (response, error) in
                if response != nil {
                    let responseModel = LoginResponseModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    //                let errorModel = BEError.init(json: error )
                    completionHandler(nil , error)
                }
        }
        loginRequest.send()
    }
}
