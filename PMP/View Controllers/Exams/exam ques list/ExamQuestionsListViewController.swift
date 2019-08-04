//
//  ExamQuestionsListViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/11/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

protocol  ExamQuestionsListDelegate{
    func questionSelected(question : ExamQuestionFull)
}

class ExamQuestionsListViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var delegate : ExamQuestionsListDelegate?
    var presenter: ExamQuestionsListPresentation?
    var examQuestions : [ExamQuestionFull]? 
    @IBOutlet weak var submitView: SubmitButtonView!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        submitView.submitButton.setTitle("CANCEL", for: .normal)
        self.submitView.submitButton.addTarget(self, action: #selector(cancel), for: UIControlEvents.touchUpInside)
    }
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ExamQuestionsListViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Exam"
    }
}

extension ExamQuestionsListViewController: ExamQuestionsListView {
    // TODO: implement view output methods
}

extension ExamQuestionsListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let examQuess = examQuestions{
            return examQuess.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ExamListCellID")
        (cell?.viewWithTag(5) as! UILabel).text = "\(indexPath.row+1)-" + examQuestions![indexPath.row].questionE!
        if examQuestions![indexPath.row].userAnswer.count > 0{
            (cell?.viewWithTag(6) as! UILabel).text = "Answer: \(examQuestions![indexPath.row].userAnswer)"
        }else{
            (cell?.viewWithTag(6) as! UILabel).text = "Answer: Not Answered"
        }
        
        if examQuestions![indexPath.row].isFlagged{
            (cell?.viewWithTag(7) as! UIImageView).isHidden = false
        }else{
            (cell?.viewWithTag(7) as! UIImageView).isHidden = true
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension ExamQuestionsListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if delegate != nil{
            delegate?.questionSelected(question: examQuestions![indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }
    }
}
