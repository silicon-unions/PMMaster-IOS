//
//  NotesInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/19/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import Gloss

class NotesInteractor {

    // MARK: Properties

    weak var output: NotesInteractorOutput?
    
    func callUserNotes(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let notesService  = NotesService()
        notesService.start(params: params, completionHandler: handler)
    }
    func callSyncNotes(params:[String:Any],handler : @escaping (BaseModel?,Error?) -> Void) {
        let notesService  = NotesService()
        notesService.startSyncNote(params: params, completionHandler: handler)
    }
    func deleteNoteCall(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let notesService  = NotesService()
        notesService.startDeleteNote(params: params, completionHandler: handler)
    }
}

extension NotesInteractor: NotesUseCase {
    // TODO: Implement use case methods
}
