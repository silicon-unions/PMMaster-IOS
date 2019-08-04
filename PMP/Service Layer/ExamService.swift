//
//  ExamService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamService{
    
    
    func start(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.getExam,httpMethod: .post,bodyParams:params) { (response, error) in
                if response != nil {
                    let responseModel = ExamQuestionDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    completionHandler(nil , error)
                }
        }
        forgotPasswordRequest.send()
    }
    
    func startReport(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.reportQuestion,httpMethod: .post,bodyParams:params) { (response, error) in
                if response != nil {
                    let responseModel = AppBaseModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    completionHandler(nil , error)
                }
        }
        forgotPasswordRequest.send()
    }
    
    func startPreviousExams( completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let forgotPasswordRequest =
            BaseRequest.init(url: URLs.Path.previousExams,httpMethod: .get) { (response, error) in
                if response != nil {
                    let responseModel = AppBaseModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    completionHandler(nil , error)
                }
        }
        forgotPasswordRequest.sendGet()
    }
}
