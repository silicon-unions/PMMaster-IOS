//
//  PMPResult.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

enum VFResult<ResponseModel, ErrorModel>{
    case success(ResponseModel)
    case failure(ErrorModel)
}
