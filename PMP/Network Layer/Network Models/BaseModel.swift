//
//  BaseModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import Gloss

class BaseModel: NSObject, Glossy {

    override init() {
    }
    
    //MARK: Glossy parsing methods
    
    required init?(json: JSON) {
        debugPrint("Initializing empty response object")
    }
    
    func toJSON() -> JSON? {
        return nil
    }
}
