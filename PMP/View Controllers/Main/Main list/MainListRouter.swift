//
//  MainListRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class MainListRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MainListViewController {
        let viewController = UIStoryboard.loadViewController() as MainListViewController
        let presenter = MainListPresenter()
        let router = MainListRouter()
        let interactor = MainListInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    
    static func logout(navigation : UINavigationController){
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(nil, forKey: "userName")
        defaults.set(nil, forKey: "password")
        
        navigation.popToRootViewController(animated: false)
        
        let loginViewController = UIStoryboard(name: "LoginAndRegistration", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigation.pushViewController(loginViewController, animated: false)
        
        navigation.dismiss(animated: true, completion: nil)
    }

//    static func showAskInstructor(view : UIViewController){
//        let askInstructorVC = AskInstructorRouter.setupModule()
//        
////        for vc in navigation.viewControllers {
////            // Check if the view controller is of MyGroupViewController type
////            if let mainViewViewController = vc as? MainViewViewController {
////                navigation.popToViewController(mainViewViewController, animated: false)
////            }
////        }
//        
//        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController
//        
//        navigation.pushViewController(askInstructorVC, animated: true)
//        
//    }
}

extension MainListRouter: MainListWireframe {
    // TODO: Implement wireframe methods
}
