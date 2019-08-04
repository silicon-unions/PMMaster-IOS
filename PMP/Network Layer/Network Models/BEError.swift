//
//  BEError.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import Gloss

class BEError: Glossy ,Error{
    var message: String?
    var description: String?
    
    required init?(json: JSON) {
        message = "message" <~~ json
        description = "description" <~~ json
    }
    
    required init?(msg:String , desc:String) {
        message = msg
        description = desc
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "message" ~~> message,
            "description" ~~> description
            ])
    }
}
