//
//  NotesService.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/25/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Alamofire
import Gloss

class NotesService {
    func start(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.userNotes, httpMethod: .get, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = NotesDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.sendGet()
    }
    
    func startAddNote(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.addUserNotes, httpMethod: .post, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = AddNoteDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
//                    let errorModel = BEError.init(json:error)
                    completionHandler(nil , error)
                }
        }
        registrationRequest.send()
    }
    
    func startUpdateNote(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.deleteNote, httpMethod: .post, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = NotesDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
    
    func startDeleteNote(params: [String:String], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.deleteNote, httpMethod: .post, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = NotesDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , errorModel)
                }
        }
        registrationRequest.send()
    }
    
    func startSyncNote(params: [String:Any], completionHandler: @escaping (_ DataModel:  BaseModel?, _ error: Error?) -> Void) {
        
        let registrationRequest =
            BaseRequest.init(url: URLs.Path.syncNotes, httpMethod: .post, bodyParams: params) { (response, error) in
                if response != nil {
                    let responseModel = NotesDataModel.init(json: response!)
                    completionHandler(responseModel , nil)
                } else {
//                    let errorModel = BEError.init(json: response!)
                    completionHandler(nil , error)
                }
        }
        registrationRequest.send()
    }
}
