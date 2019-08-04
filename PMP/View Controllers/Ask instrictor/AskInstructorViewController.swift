//
//  AskInstructorViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static let askInstrutorListCallNotification = Notification.Name("askInstrutorListCallNotification")
    static let askInstrutoraddQuesNotification = Notification.Name("askInstrutoraddQuesNotification")
}

class AskInstructorViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: AskInstructorPresentation?
    var instructorQuestions : Array<InstructorQuestion> = []

    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var submitView: SubmitButtonView!
    @IBOutlet weak var tableView: UITableView!
    
    var sender : UIButton?
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitView.submitButton.setTitle("ADD", for: UIControlState.normal)
        submitView.submitButton.addTarget(self, action: #selector(addQuestion), for: UIControlEvents.touchUpInside)
        
        self.presenter = AskInstructorPresenter()
        (presenter as! AskInstructorPresenter).view = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(callAskInstrutorList), name: .askInstrutorListCallNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addQuestion), name: .askInstrutoraddQuesNotification, object: nil)
        
        tableView.register(UINib(nibName: AskInstructorTableViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: AskInstructorTableViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc func addQuestion(_ sender: Any) {
        AskInstructorRouter.presentAddQuestion(view: self)
    }
    @IBAction func showMenu(_ sender: Any) {
        self.showList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.callAskInstrutorList()
    }
    
    @objc func callAskInstrutorList() {
        (presenter as! AskInstructorPresenter).callAskInstrucor()
    }
    
    @objc func addAnotherQues() {
        self.addQuestion(self)
    }
    
    @objc func deleteQuestion(sender : UIButton){
        self.sender = sender
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.isOnlyOneButton = false
        alertVC.titleText = "Alert"
        alertVC.delegate = self
        alertVC.bodyText = "Are you sure that you want to delete this question"
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
}

extension AskInstructorViewController: AskInstructorView {
    // TODO: implement view output methods
}

extension AskInstructorViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if instructorQuestions.count == 0{
            self.emptyLabel.isHidden = false
        }else{
            self.emptyLabel.isHidden = true
        }
        return instructorQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AskInstructorTableViewCell.identifier) as! AskInstructorTableViewCell
        
        cell.configureCell(instructorQues: instructorQuestions[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteQuestion), for: .touchUpInside)
        
        return cell
    }
}
extension AskInstructorViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        AskInstructorRouter.presentQuestionDetail(view: self,question: instructorQuestions[indexPath.row])
    }
}

extension AskInstructorViewController : AlertViewControllerDelegate{
    func okButtonPressed(type:DialogType){
        (presenter as! AskInstructorPresenter).calldeleteQuestion(withID:instructorQuestions[(self.sender?.tag)!].questionId!)
    }
    func cancelButtonPressed(type:DialogType){
        
    }
    
}
