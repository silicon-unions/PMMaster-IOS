//
//  ProfileService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

class ProfileService{
    
    
    func start(completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.getProfile,httpMethod: .get,bodyParams:nil) { (response, error) in
                if response != nil {
                    let responseModel = ProfileDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        forgotPasswordRequest.sendGet()
    }
    
    func startUpdateProfile(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.updateProfile,httpMethod: .post,bodyParams:params) { (response, error) in
                if response != nil {
                    let responseModel = AppBaseModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        forgotPasswordRequest.send()
    }
}

