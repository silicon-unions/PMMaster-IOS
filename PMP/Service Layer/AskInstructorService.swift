//
//  AskInstructorService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Alamofire

class AskInstructorService {
    
    func start(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.askInstructor, httpMethod: .get, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = AskInstructorDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(msg: "Error", desc: "Something Went Wrong")
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.sendGet()
    }
    
    func startAddQuestion(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.addQuestion, httpMethod: .post, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = AddQuestionDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(msg: "Error", desc: "Something Went Wrong")
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
    
    func startDeleteQuestion(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.deleteQuestion, httpMethod: .post, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = AskInstructorDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(msg: "Error", desc: "Something Went Wrong")
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
    
    func startSeenQuestion(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.seenQuestion, httpMethod: .post, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = AskInstructorDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(msg: "Error", desc: "Something Went Wrong")
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
}
