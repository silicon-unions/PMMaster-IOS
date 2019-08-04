//
//  LoginResponseModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import Gloss

class LoginResponseModel: AppBaseModel {
    let userName : String?
    let token : String?
    
    required init?(json: JSON){
        userName = "user.name" <~~ json
        token = "user.api_token" <~~ json
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Encodable
    override func toJSON() -> JSON? {
        return jsonify([
            "user.name" ~~> userName,
            "user.api_token" ~~> token
            ])
    }
}
