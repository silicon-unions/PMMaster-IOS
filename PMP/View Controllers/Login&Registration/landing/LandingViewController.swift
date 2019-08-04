//
//  LandingViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/15/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class LandingViewController: BaseViewController {

    // MARK: Properties

    var presenter: LandingPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension LandingViewController: LandingView {
    // TODO: implement view output methods
}


extension LandingViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "LoginAndRegistration"
    }
}
