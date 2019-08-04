//
//  ExamQuestionDataModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import Gloss

class ExamQuestion: AppBaseModel {
    
    var questionId : Int?
    var questionE : String?
    var questionA : String?
    
    var answerE1 : String?
    var answerE2 : String?
    var answerE3 : String?
    var answerE4 : String?
    
    var answerA1 : String?
    var answerA2 : String?
    var answerA3 : String?
    var answerA4 : String?
    
    var correctAnswer : String?
    var processGroup : String?
    var knowledgeArea : String?
    
    var level : String?
    var justificationE : String?
    var justificationA : String?
    
    var timeRemainig : Int? = 300
    
    // MARK: Lifecycle
    required init?(json: JSON){
        self.questionId = "id" <~~ json
        self.questionE = "questionE" <~~ json
        self.questionA = "questionA" <~~ json
        
        self.answerE1 = "answerE1" <~~ json
        self.answerE2 = "answerE2" <~~ json
        self.answerE3 = "answerE3" <~~ json
        self.answerE4 = "answerE4" <~~ json
        
        self.answerA1 = "answerA1" <~~ json
        self.answerA2 = "answerA2" <~~ json
        self.answerA3 = "answerA3" <~~ json
        self.answerA4 = "answerA4" <~~ json
        
        self.correctAnswer = "answer" <~~ json
        self.processGroup = "processGroup" <~~ json
        self.knowledgeArea = "knowledgeArea" <~~ json
        
        self.level = "level" <~~ json
        self.justificationE = "justificationE" <~~ json
        self.justificationA = "justificationA" <~~ json
        
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func toJSON() -> JSON? {
        return jsonify([
            ])
    }
}

class ExamQuestionDataModel : AppBaseModel {

    var examQuestionsModelArray : [ExamQuestion]?
    
    // MARK: Lifecycle
    required init?(json: JSON){
        self.examQuestionsModelArray = "questions" <~~ json
        
        
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func toJSON() -> JSON? {
        return super.toJSON()
    }
}

