//
//  MainListDataModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import Gloss

class MainListDataModel : AppBaseModel {

    // MARK: Lifecycle
    required init?(json: JSON){
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func toJSON() -> JSON? {
        return super.toJSON()
    }
}

