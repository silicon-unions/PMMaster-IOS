//
//  ForgotPasswordService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

class ForgotPasswordService{

    
    func start(params: String, completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.forgotPassword, bodyParams: ["email":params]) { (response, error) in
                if response != nil {
                    let responseModel = ForgotPasswordModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        forgotPasswordRequest.send()
    }
}
