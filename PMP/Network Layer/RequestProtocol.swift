//
//  RequestProtocol.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var url: URLs.Path{get}
    var httpMethod: URLs.HttpMethod {get}
    var headers :[String: String] {get}
    var bodyParameters: [String: Any]? {get}
    var completion:(_ DataModel:  [String : AnyObject]?, _ error: Error?) -> Void {get}
}
