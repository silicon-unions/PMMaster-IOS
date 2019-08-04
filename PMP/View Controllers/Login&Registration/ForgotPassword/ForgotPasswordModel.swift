//
//  ForgotPasswordModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import Gloss

class ForgotPasswordModel: AppBaseModel {

    
    required init?(json: JSON){
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Encodable
    override func toJSON() -> JSON? {
//        return jsonify([
//
//            ])
        
        return super.toJSON()
    }
}
