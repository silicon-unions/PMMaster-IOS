//
//  QuestionDetailViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class QuestionDetailViewController: BaseViewController {

    // MARK: Properties

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var askNewQuestionButton: UIButton!
    
    
    var instructorQuestion : InstructorQuestion? = nil
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func askNewQuestion(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .askInstrutoraddQuesNotification, object: nil)
    }
    var presenter: QuestionDetailPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = QuestionDetailPresenter()
        (presenter as! QuestionDetailPresenter).view = self
        
        self.questionLabel.text = instructorQuestion?.questionString
        if let answer = instructorQuestion?.answerString{
            self.answerLabel.text = answer
            (presenter as! QuestionDetailPresenter).callSeenQuestion()
        }else{
            self.answerLabel.text = "This Question does not answer yet, Please try in another time Thank you"
            (presenter as! QuestionDetailPresenter).callSeenQuestion()
        }
        
        
        doneButton.setTitleColor(UIColor.PMPBlue, for: .normal)
        askNewQuestionButton.setTitleColor(UIColor.PMPBlue, for: .normal)
    }
}

extension QuestionDetailViewController: QuestionDetailView {
    // TODO: implement view output methods
}

extension QuestionDetailViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "AskInstructor"
    }
}
