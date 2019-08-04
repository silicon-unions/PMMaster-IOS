//
//  RegistrationModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/18/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import Gloss

class RegistrationModel: AppBaseModel {
    let name : String?
    let email : String?
    let apiToken : String?
    
    required init?(json: JSON){
        name = "user.name" <~~ json
        email = "user.email" <~~ json
        apiToken = "user.api_token" <~~ json
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Encodable
    override func toJSON() -> JSON? {
        return jsonify([
            "user.name" ~~> name,
            "user.email" ~~> email,
            "user.apiToken" ~~> apiToken
            ])
    }
}
