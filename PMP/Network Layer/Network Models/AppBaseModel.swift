//
//  AppBaseModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import Gloss

class AppBaseModel: BaseModel {
    let success : Bool?
    let message : String?
    let reason : String?
    
    required init?(json: JSON){
        success = "success" <~~ json
        message = "message" <~~ json
        reason = "reason" <~~ json
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Encodable
    override func toJSON() -> JSON? {
        return jsonify([
            "success" ~~> success,
            "message" ~~> message,
            "reason" ~~> reason
            ])
    }
}
