//
//  QuestionReportViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/13/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class QuestionReportViewController: BaseViewController {

    // MARK: Properties
    var presenter: QuestionReportPresenter?
    var question : ExamQuestionFull?
    var practiceQuestion : PracticeQuestionFull?
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var isForReport = true
    
    // MARK: Lifecycle
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        self.presenter = QuestionReportPresenter()
        self.presenter?.view = self
        
        
        if isForReport == false {
            agreeButton.setTitle("ADD", for: .normal)
            titleLabel.text = "Note"
        }
    }
    
    func setupView() {
        
    }
    
    @IBAction func sendReport(_ sender: Any) {
        if isForReport == false{

            let note = UserNoteFull()
            
            note.note = textView.text
            note.index = NotesDBManager.sharedInstance.getNotesFromDB().count
            note.noteId = 0
            note.noteType = "question"
            if let pracQues = self.practiceQuestion{
                note.noteQuestionId = pracQues.questionId
                note.noteQuestion = pracQues.questionE
            }else{
                note.noteQuestionId = (question?.questionId)!
                note.noteQuestion = question?.questionE
            }
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
            note.noteUpdatedDate = formatter.string(from: date)
            note.isDeleted = false
            
            NotesDBManager.sharedInstance.addData(object: note)
            
            self.dismiss(animated: true, completion: nil)
            
            return
        }
        
        if textView.text.count > 0 {
            self.presenter?.callExam()
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension QuestionReportViewController: QuestionReportView {
    // TODO: implement view output methods
}

extension QuestionReportViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Exam"
    }
}
