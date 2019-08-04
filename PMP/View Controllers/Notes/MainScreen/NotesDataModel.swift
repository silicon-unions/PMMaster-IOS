//
//  NotesDataModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/19/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import Gloss
import RealmSwift

enum NoteType {
    case Personal
    case Question
}


    
class UserNote: AppBaseModel{
    
    var noteId : Int?
    var noteType : String?
    var noteQuestionId : Int? = -1
    var noteUpdatedDate : String?
    var note : String?
    var noteTypeEnum : NoteType?
    var isDeleted : Bool = false
    
    // MARK: Lifecycle
        
    required init?(json: JSON){
        self.noteId = "id" <~~ json
        self.note = "note" <~~ json
        
        self.noteType = "type" <~~ json
        if self.noteType == "personal"{
            self.noteTypeEnum = .Personal
        }else{
            self.noteTypeEnum = .Question
        }
        self.noteQuestionId = ("question_id" <~~ json)
        self.noteUpdatedDate = "updated_at" <~~ json
        
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> noteId,
            "note" ~~> note,
            "type" ~~> noteType,
            "question_id" ~~> noteQuestionId,
            "updated_at" ~~> noteUpdatedDate,
            "is_deleted" ~~> isDeleted
            ])
    }
}


class NotesDataModel : AppBaseModel {
    var userNotesArray : [UserNote]?
    // MARK: Lifecycle
    required init?(json: JSON){
        userNotesArray = "notes" <~~ json
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func toJSON() -> JSON? {
        return jsonify([
            "notes" ~~> userNotesArray
            ])
    }
    
}

