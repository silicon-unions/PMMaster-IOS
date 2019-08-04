//
//  ExamHistoryViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamHistoryViewController: BaseViewController {

    // MARK: Properties

    var presenter: ExamHistoryPresentation?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitView: UIView!
    var exams : [Exam]?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.presenter = ExamHistoryPresenter()
        (self.presenter as! ExamHistoryPresenter).view = self
        
        self.exams = ExamsDBManager.sharedInstance.getExamsFromDB()
    }

    func calExamStatus(exam: Exam) -> (correct: Int , wrong: Int) {
        var correctNumber = 0
        var wrongNumber = 0
        for question in exam.examQuestions{
            if question.correctAnswer == question.userAnswer{
                correctNumber += 1
            }else{
                wrongNumber += 1
            }
        }
        return (correctNumber,wrongNumber)
    }
}

extension ExamHistoryViewController: ExamHistoryView {
    // TODO: implement view output methods
}

extension ExamHistoryViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Exam"
    }
}

extension ExamHistoryViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let exams = self.exams{
            return exams.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ExamCellID")
        
        (cell?.viewWithTag(5) as! UILabel).text = "Exam \(indexPath.row+1)"
        (cell?.viewWithTag(6) as! UILabel).text = "Done At \(self.exams![indexPath.row].examTime)"
        
        let percentage : Double = Double(calExamStatus(exam: self.exams![indexPath.row]).correct/self.exams![indexPath.row].examQuestions.count * 100)
        (cell?.viewWithTag(7) as! UILabel).text = "\(String(format: "%.0f", percentage))%"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension ExamHistoryViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
//        let oldExamVC = UIStoryboard.instantiateViewControlle
//        oldExamVC.examQuestions = Array(self.exams![indexPath.row].examQuestions)
        
        let storyboard = UIStoryboard(name: "Exam", bundle: nil)
        let oldExamVC = storyboard.instantiateViewController(withIdentifier :"OldExamViewController") as! OldExamViewController
        oldExamVC.questions = Array(self.exams![indexPath.row].examQuestions)
        oldExamVC.isViewer = true
        self.navigationController?.pushViewController(oldExamVC, animated: true)
    }
}
