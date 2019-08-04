//
//  NotesViewModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/19/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import RealmSwift

class UserNoteFull: Object {
    @objc dynamic var index : Int = -1
    @objc dynamic var noteId : Int = -1
    @objc dynamic var noteType : String?
    @objc dynamic var noteQuestionId : Int = -1
    @objc dynamic var noteQuestion : String?
    @objc dynamic var noteUpdatedDate : String?
    @objc dynamic var note : String?
    @objc dynamic var noteTypeEnum = 0
    @objc dynamic var isDeleted = false
}
class NotesViewModel {
    var userNotes = Array<UserNoteFull>()
}

