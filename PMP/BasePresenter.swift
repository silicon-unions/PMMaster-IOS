//
//  VFBasePresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class BasePresenter: NSObject {

    private weak var view: UIView?
    
    func attachView(view: UIView) {
        self.view = view
    }
    
    func getView() -> UIView? {
        return view
    }
    
    func isViewAttached() -> Bool {
        return view == nil
    }
    
    func detachView() {
        view = nil
    }
    
    func loadViewData() {
        
    }
    
}
