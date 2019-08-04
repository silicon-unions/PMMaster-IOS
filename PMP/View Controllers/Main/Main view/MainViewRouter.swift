//
//  MainViewRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class MainViewRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MainViewViewController {
        let viewController = UIStoryboard.loadViewController() as MainViewViewController
        let presenter = MainViewPresenter()
        let router = MainViewRouter()
        let interactor = MainViewInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    
    static func showMainList(navigation : UINavigationController){
        let mainListVC = MainListRouter.setupModule()
        mainListVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        navigation.present(mainListVC, animated: true, completion: nil)
        mainListVC.navController = navigation
    }
    
    static func showNotes(navigation : UINavigationController){
        navigation.dismiss(animated: false, completion: nil)
        backToMainController(navController: navigation)
        let notesVC = NotesRouter.setupModule()
        navigation.pushViewController(notesVC, animated: true)
    }
    
    static func showProfile(navigation : UINavigationController){
        navigation.dismiss(animated: false, completion: nil)
        backToMainController(navController: navigation)
        let profileVC = ProfileRouter.setupModule()
        navigation.pushViewController(profileVC, animated: true)
    }
    
    static func showAskInstructor(navController : UINavigationController){
        navController.dismiss(animated: false, completion: nil)
        
        let askInstructorVC = AskInstructorRouter.setupModule()
        for vc in navController.viewControllers {
            // Check if the view controller is of MyGroupViewController type
            if let mainViewViewController = vc as? MainViewViewController {
                navController.popToViewController(mainViewViewController, animated: false)
            }
        }
        navController.pushViewController(askInstructorVC, animated: false)
    }
    
    static func backToMainController(navController : UINavigationController) {
        for vc in navController.viewControllers {
            if let mainViewViewController = vc as? MainViewViewController { navController.popToViewController(mainViewViewController, animated: false)
            }
        }
    }
    
    static func showHome(navController : UINavigationController) {
        navController.dismiss(animated: false, completion: nil)
        for vc in navController.viewControllers {
            if let mainViewViewController = vc as? MainViewViewController { navController.popToViewController(mainViewViewController, animated: false)
            }
        }
    }
    
    static func showExam(navigation : UINavigationController){
        navigation.dismiss(animated: false, completion: nil)
        backToMainController(navController: navigation)
        let examVC = ExamOptionsRouter.setupModule()
        navigation.pushViewController(examVC, animated: true)
    }
    
    static func showPractices(navigation : UINavigationController){
        navigation.dismiss(animated: false, completion: nil)
        backToMainController(navController: navigation)
        let practiceMainVC = PracticeMainRouter.setupModule()
        navigation.pushViewController(practiceMainVC, animated: true)
    }
    
    static func showExamHistory(navigation : UINavigationController){
        navigation.dismiss(animated: false, completion: nil)
        backToMainController(navController: navigation)
        let examHistoryVC = ExamHistoryRouter.setupModule()
        navigation.pushViewController(examHistoryVC, animated: true)
    }

    static func popToHome(navController : UINavigationController){
        navController.dismiss(animated: false, completion: nil)
        
        for vc in navController.viewControllers {
            // Check if the view controller is of MyGroupViewController type
            if let mainViewViewController = vc as? MainViewViewController {
                navController.popToViewController(mainViewViewController, animated: false)
            }
        }
    }
    
}

extension MainViewRouter: MainViewWireframe {
    // TODO: Implement wireframe methods
}
