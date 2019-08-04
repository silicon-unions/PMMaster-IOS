//
//  NetworkManager.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {

    static func makeRequest(_ request: BaseRequest){
        
//        Alamofire.request(request.url.rawValue, method: Alamofire.HTTPMethod.post, parameters: request.bodyParameters, headers: ["" : ""])
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.authenToken.count > 0{
            request.headers["Authorization"] = "Bearer " + appDelegate.authenToken
        }
        
        
        
//        var method = Alamofire.HTTPMethod(rawValue: "")
//        if request.httpMethod == .get{
//            method = Alamofire.HTTPMethod.get
//        }else{
//            method = Alamofire.HTTPMethod.post
//        }
        
        
        Alamofire.request(request.url.rawValue,method : Alamofire.HTTPMethod.post ,parameters : request.bodyParameters,encoding: JSONEncoding.default ,headers: request.headers)
            .responseJSON { response in
                
                
                if let _ = response.result.value {
                    request.completion((try? JSONSerialization.jsonObject(with: response.data!, options: [])) as? [String : AnyObject], nil)
                }else if response.result.isFailure {
                    if let error = response.result.error as? AFError, error.responseCode == 499 {
                        request.completion(nil, response.result.error)
                    } else {
                        request.completion(nil, response.result.error)
                    }
                }
        }
    }
    
    static func makeGetRequest(_ request: BaseRequest){
        
        //        Alamofire.request(request.url.rawValue, method: Alamofire.HTTPMethod.post, parameters: request.bodyParameters, headers: ["" : ""])
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        var header = ["Authorization" : ""]
//
//        if appDelegate.authenToken.count > 0{
//            header = ["Authorization" : appDelegate.authenToken]
//        }
        
        var headers:HTTPHeaders = ["" : ""]

        if appDelegate.authenToken.count > 0{
            headers = ["Authorization": "Bearer " + appDelegate.authenToken]
        
        }
        
        
        //        var method = Alamofire.HTTPMethod(rawValue: "")
        //        if request.httpMethod == .get{
        //            method = Alamofire.HTTPMethod.get
        //        }else{
        //            method = Alamofire.HTTPMethod.post
        //        }
        
        Alamofire.request(request.url.rawValue,method : Alamofire.HTTPMethod.get ,parameters : request.bodyParameters, headers: headers)
            .responseJSON { response in
                
                
                if let _ = response.result.value {
                    request.completion((try? JSONSerialization.jsonObject(with: response.data!, options: [])) as? [String : AnyObject], nil)
                }else if response.result.isFailure {
                    if let error = response.result.error as? AFError, error.responseCode == 499 {
                        request.completion(nil, response.result.error)
                    } else {
                        request.completion(nil, response.result.error)
                    }
                }
        }
    }
    
    
    static func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: (([String : AnyObject]?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = "http://google.com" /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
    static func upload(image: UIImage, completionHandler: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        
            
            
            
            
            let pageURL = "http://www.professionalengineers.us/pmpmaster/public/api/profilePicture"
            // init paramters Dictionary
            var parameters = [
                "cat_id": "2"
            ]
            
            // example image data
//            let image = #imageLiteral(resourceName: "new image")
            
            let imageData = UIImagePNGRepresentation(image)
            
            
            // CREATE AND SEND REQUEST ----------
            //let imageData = UIPNGRepresentation(image)!
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
                
                multipartFormData.append(imageData!, withName: "profilePicture", fileName: "new image", mimeType: "image/jpeg")
            }, to:pageURL,method: .post,headers: ["Authorization":"Bearer \((UIApplication.shared.delegate as! AppDelegate).authenToken)","Accept" : "application/json"] as HTTPHeaders,encodingCompletion:completionHandler)

            
            ///
        
    }
}
