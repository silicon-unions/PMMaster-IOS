//
//  AddNoteInteractor.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/26/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class AddNoteInteractor {

    // MARK: Properties

    weak var output: AddNoteInteractorOutput?
    
    func addNoteCall(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let notesService  = NotesService()
        notesService.startAddNote(params: params, completionHandler: handler)
    }
    func addUpdateCall(params:[String:String],handler : @escaping (BaseModel?,Error?) -> Void) {
        let notesService  = NotesService()
        notesService.startUpdateNote(params: params, completionHandler: handler)
    }
}

extension AddNoteInteractor: AddNoteUseCase {
    // TODO: Implement use case methods
}
