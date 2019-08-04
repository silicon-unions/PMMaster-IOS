//
//  RegistrationDataModelViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class RegistrationDataModelViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: RegistrationDataModelPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RegistrationDataModelViewController: RegistrationDataModelView {
    // TODO: implement view output methods
}
