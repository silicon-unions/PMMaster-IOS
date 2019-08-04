//
//  AskInstructorDataModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import Gloss

class InstructorQuestion: AppBaseModel {
    
    let questionId: Int?
    let questionString: String?
    let answerString: String?
    let seenString: String?
    let isSeen: Bool?
    let updatedDate : String?
    
    // MARK: - Deserialization
    
    required init?(json: JSON) {
        self.questionId = "id" <~~ json
        self.questionString = "question" <~~ json
        self.answerString = "answer" <~~ json
        self.seenString = "seen" <~~ json
        if self.seenString == "0"{
            self.isSeen = false
        }else{
            self.isSeen = true
        }
        
        self.updatedDate = "updated_at" <~~ json
        
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Serialization
    
    override func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.questionId,
            "question" ~~> self.questionString,
            "answer" ~~> self.answerString,
            "seen" ~~> self.isSeen,
            "updated_at" ~~> self.updatedDate
            ])
        
    }
}

import Gloss
    
class AskInstructorDataModel : AppBaseModel {

//    let instructorQuestionsArray : Array
    
    var instructorQuestionsArray : [InstructorQuestion]?
    // MARK: Lifecycle
    required init?(json: JSON){
        instructorQuestionsArray = "instructorQuestions" <~~ json
        super.init(json: json)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func toJSON() -> JSON? {
        return super.toJSON()
    }
}

