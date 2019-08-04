//
//  AboutViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 9/20/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: BaseViewController {

    // MARK: Properties

    var presenter: AboutPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func ok(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AboutViewController: AboutView {
    // TODO: implement view output methods
}

extension AboutViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Profile"
    }
}
