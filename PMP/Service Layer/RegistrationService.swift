//
//  RegistrationService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

class RegistrationService{
    
    
    func start(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.Register, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = RegistrationModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
    
    func startWithFB(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.registerWithFB, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = RegistrationModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
    
    func startWithLinkedIn(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.registerWithLinkedIn, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = RegistrationModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
}
