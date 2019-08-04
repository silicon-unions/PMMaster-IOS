//
//  MainListViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import Advance

class MainListViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var homeView: UIButton!
    @IBOutlet weak var practicesView: UIButton!
    @IBOutlet weak var examView: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var askInstructorButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var examsHistoryButton: UIButton!
    
    @IBOutlet weak var dismissButton: UIButton!
    var presenter: MainListPresentation?
    var navController : UINavigationController? = nil

    // MARK: Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.isHidden = true
        self.homeView.isHidden = true
        self.practicesView.isHidden = true
        self.examView.isHidden = true
        self.notesButton.isHidden = true
        self.askInstructorButton.isHidden = true
        self.profileButton.isHidden = true
        examsHistoryButton.isHidden = true
        
        self.homeView.backgroundColor = UIColor.init(hex: "a027b7")
        self.practicesView.backgroundColor = UIColor.init(hex: "941fab")
        self.examView.backgroundColor = UIColor.init(hex: "7525a4")
        self.notesButton.backgroundColor = UIColor.init(hex: "5e2ea3")
        self.askInstructorButton.backgroundColor = UIColor.init(hex: "4238a1")
        self.profileButton.backgroundColor = UIColor.init(hex: "333c9e")
        self.examsHistoryButton.backgroundColor = UIColor.init(hex: "333c9e")
        
        
        self.addUIEffects(sender: self.homeView)
        self.addUIEffects(sender: self.practicesView)
        self.addUIEffects(sender: self.examView)
        self.addUIEffects(sender: self.notesButton)
        self.addUIEffects(sender: self.askInstructorButton)
        self.addUIEffects(sender: self.profileButton)
        self.addUIEffects(sender: self.examsHistoryButton)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        MainListRouter.logout(navigation: navController!)
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showProfile(_ sender: Any) {
        MainViewRouter.showProfile(navigation: navController!)
    }
    
    @IBAction func showNotes(_ sender: Any) {
        MainViewRouter.showNotes(navigation: navController!)
    }
    @IBAction func showAskInstructor(_ sender: Any) {
//        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//        MainListRouter.showAskInstructor(navigation: appDelegate.window?.rootViewController.
        MainViewRouter.showAskInstructor(navController: navController!)
    }
    @IBAction func showExam(_ sender: Any) {
        MainViewRouter.showExam(navigation: navController!)
    }
    @IBAction func showHome(_ sender: Any) {
        MainViewRouter.showHome(navController: navController!)
    }
    
    @IBAction func showExamHistory(_ sender: Any) {
        MainViewRouter.showExamHistory(navigation: navController!)
    }
    @IBAction func showPractices(_ sender: Any) {
        MainViewRouter.showPractices(navigation: navController!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.isHidden = false
        self.animate()
    }
    
    func animate() {
        self.homeView.isHidden = false
        self.practicesView.isHidden = false
        self.examView.isHidden = false
        self.notesButton.isHidden = false
        self.askInstructorButton.isHidden = false
        self.profileButton.isHidden = false
        self.examsHistoryButton.isHidden = false
        
        self.homeView.center.x = self.homeView.center.x + 100
        self.homeView.center.y = self.homeView.center.y + 500
        self.practicesView.center.x = self.practicesView.center.x + 100
        self.practicesView.center.y = self.practicesView.center.y + 500
        self.examView.center.x = self.examView.center.x + 100
        self.examView.center.y = self.examView.center.y + 500
        self.notesButton.center.x = self.notesButton.center.x + 100
        self.notesButton.center.y = self.notesButton.center.y + 500
        self.askInstructorButton.center.x = self.askInstructorButton.center.x + 100
        self.askInstructorButton.center.y = self.askInstructorButton.center.y + 500
        self.profileButton.center.x = self.profileButton.center.x + 100
        self.profileButton.center.y = self.profileButton.center.y + 500
        self.examsHistoryButton.center.x = self.examsHistoryButton.center.x + 100
        self.examsHistoryButton.center.y = self.examsHistoryButton.center.y + 500
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            
            self.homeView.center.x = self.homeView.center.x - 100
            self.homeView.center.y = self.homeView.center.y - 500
            
        }, completion:nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            
            self.practicesView.center.x = self.practicesView.center.x - 100
            self.practicesView.center.y = self.practicesView.center.y - 500
            
        }, completion:nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.3, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            
            self.examView.center.x = self.examView.center.x - 100
            self.examView.center.y = self.examView.center.y - 500
            
        }, completion:nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.4, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            
            self.notesButton.center.x = self.notesButton.center.x - 100
            self.notesButton.center.y = self.notesButton.center.y - 500
            
        }, completion:nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            
            self.askInstructorButton.center.x = self.askInstructorButton.center.x - 100
            self.askInstructorButton.center.y = self.askInstructorButton.center.y - 500
            
        }, completion:nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.6, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            
            self.profileButton.center.x = self.profileButton.center.x - 100
            self.profileButton.center.y = self.profileButton.center.y - 500
            
        }, completion:nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.6, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            
            self.examsHistoryButton.center.x = self.examsHistoryButton.center.x - 100
            self.examsHistoryButton.center.y = self.examsHistoryButton.center.y - 500
            
        }, completion:nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addUIEffects(sender : UIButton) {
        sender.layer.cornerRadius = 15.0
        sender.layer.borderWidth = 0.5
        sender.layer.borderColor = UIColor.lightGray.cgColor
        sender.layer.shadowColor = UIColor.black.cgColor
        sender.layer.shadowOpacity = 0.5
        sender.layer.shadowRadius = 3.0
        sender.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
    }
}

extension MainListViewController: MainListView {
    // TODO: implement view output methods
}

extension MainListViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "MainView"
    }
}
