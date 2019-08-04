//
//  BaseRequest.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class BaseRequest : RequestProtocol{
    var url: URLs.Path
    
    var httpMethod: URLs.HttpMethod
    
    var headers: [String : String]
    
    var bodyParameters: [String : Any]?
    
    var completion: (_ DataModel:  [String : AnyObject]?, _ error: Error?) -> Void
    
    init(url: URLs.Path,
         httpMethod: URLs.HttpMethod = .get,
         headers: [String : String] = [:],
         bodyParams: [String : Any]? = nil,
         resultHandler: @escaping (_ DataModel:  [String : AnyObject]?, _ error: Error?) -> Void) {
        self.url = url
        self.httpMethod = httpMethod
        self.headers = [:]
        self.bodyParameters = bodyParams
        self.completion = resultHandler
        self.headers = getGenericHeaders()
        
        for (key,value) in self.headers {
            self.headers.updateValue(value, forKey:key)
        }
        
    }
    
    func getGenericHeaders() -> [String: String]{
        var headers: [String: String] = [:]
        headers["Accept"] = "application/json"
//        headers["vf-country-code"] = "ES"
//        headers["Content-Type"] = "application/json"
        
        return headers
    }
    
    
    func send() {
        NetworkManager.makeRequest(self)
    }
    
    func sendGet() {
        NetworkManager.makeGetRequest(self)
    }
}
