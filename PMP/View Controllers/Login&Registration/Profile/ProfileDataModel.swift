//
//  ProfileDataModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/18/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import Gloss

class ProfileDataModel : AppBaseModel {

    let name: String?
    let email: String?
    let level: String?
    // MARK: Lifecycle
    required init?(json: JSON){
        self.name = "user.name" <~~ json
        self.email = "user.email" <~~ json
        self.level = "user.level" <~~ json
        
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func toJSON() -> JSON? {
        return jsonify([
            ])
    }
}

