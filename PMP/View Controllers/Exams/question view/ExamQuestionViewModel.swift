//
//  ExamQuestionViewModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import RealmSwift

class ExamQuestionFull : Object{
    
    @objc dynamic var questionId : Int = -1
    @objc dynamic var questionE : String?
    @objc dynamic var questionA : String?
    
    @objc dynamic var answerE1 : String?
    @objc dynamic var answerE2 : String?
    @objc dynamic var answerE3 : String?
    @objc dynamic var answerE4 : String?
    
    @objc dynamic var answerA1 : String?
    @objc dynamic var answerA2 : String?
    @objc dynamic var answerA3 : String?
    @objc dynamic var answerA4 : String?
    
    @objc dynamic var correctAnswer : String?
    @objc dynamic var processGroup : String?
    @objc dynamic var knowledgeArea : String?
    
    @objc dynamic var level : String?
    @objc dynamic var justificationE : String?
    @objc dynamic var justificationA : String?
    
    @objc dynamic var timeRemainig : Int = 0
    @objc dynamic var questionIndex : Int = -1
    @objc dynamic var userAnswer : String = ""
    @objc dynamic var isFlagged : Bool = false
}

class ExamQuestionViewModel{
    var examQuestions = Array<ExamQuestionFull>()
}

class Exam : Object{
    @objc dynamic var examId : Int = 0
    @objc dynamic var examTime : String = ""
    var examQuestions = RealmSwift.List<ExamQuestionFull>()
}

