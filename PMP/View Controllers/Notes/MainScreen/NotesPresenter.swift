//
//  NotesPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/19/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import RealmSwift
import Gloss

class NotesPresenter {

    // MARK: Properties

    var view: NotesView?
    var router: NotesWireframe?
    var interactor: NotesUseCase?
    var notesViewModel = NotesViewModel()
    
    
    func callUserNotes(){
//        let notesViewController = self.view as! NotesViewController
//
//        notesViewController.showSpinner()
//        interactor = NotesInteractor()
//        (interactor as! NotesInteractor).callUserNotes(params:[:], handler: { (model, error) in
//
//            if (model as! NotesDataModel).success!{
//                print(model!)
//                notesViewController.userNotes = (model as! NotesDataModel).userNotesArray!
//                self.prepareViewModel(dataModel: (model as! NotesDataModel))
//                self.saveNotesInDatabase()
//                notesViewController.tableView.reloadData()
//
//            }else{
//                (self.view as! RegistrationViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
//            }
//
//            notesViewController.hideSpinner()
//
//        })
        self.callSyncNotes()
    }
    
    func callSyncNotes(){
        let notesViewController = self.view as! NotesViewController
        
        notesViewController.showSpinner()
        interactor = NotesInteractor()
        let notesInJsonArray = self.prepareDataModel(userNotesFull: self.notesInDatabase()).toJSONArray()
        
        var params = Dictionary<String,Any>()
        if notesInJsonArray!.count > 0{
            params["notes"] = notesInJsonArray!
        }
//        let data = try? JSONSerialization.data(withJSONObject: x, options: [])
//        var y = self.JSONStringify(value: x as AnyObject)
        (interactor as! NotesInteractor).callSyncNotes(params:params, handler: { (model, error) in
            
            
            if error != nil {
                notesViewController.userNotes = self.notesInDatabase()
                notesViewController.hideSpinner()
                return
            }
            guard let success = (model as! NotesDataModel).success else {
                notesViewController.userNotes = self.notesInDatabase()
                notesViewController.hideSpinner()
                return
            }
            
            if success{
                print(model!)
                self.prepareViewModel(dataModel: (model as! NotesDataModel))
                notesViewController.userNotes = self.notesViewModel.userNotes
                self.saveNotesInDatabase()
                notesViewController.tableView.reloadData()
                
            }else{
                notesViewController.userNotes = self.notesInDatabase()
                (self.view as! RegistrationViewController).showDefaultAlert(message: (model as! RegistrationModel).reason!,popView: false)
            }
            
            notesViewController.hideSpinner()
            
        })
    }
    
    func prepareViewModel(dataModel:NotesDataModel){
        var index = -1
        for note in dataModel.userNotesArray!{
            index += 1
            
            let userNoteFull = UserNoteFull()
            userNoteFull.index = index
            userNoteFull.noteId = note.noteId!
            userNoteFull.noteType = note.noteType
            
            if let noteQuestionId =  note.noteQuestionId{
                userNoteFull.noteQuestionId = noteQuestionId
            }
            
            userNoteFull.noteUpdatedDate = note.noteUpdatedDate!
            userNoteFull.note = note.note!
            if note.noteTypeEnum == .Personal{
                userNoteFull.noteTypeEnum = 0
                userNoteFull.noteType = "personal"
            }else{
                userNoteFull.noteTypeEnum = 1
                userNoteFull.noteType = "question"
            }

            notesViewModel.userNotes.append(userNoteFull)
        }
    }
    
    func prepareDataModel(userNotesFull : [UserNoteFull]) -> [UserNote]{
//        let notesDataModel = NotesDataModel(json: [String:Any].init())
        var index = -1
        var userNoteArr = [UserNote]()
        for note in userNotesFull{
            index += 1
            
            let userNote = UserNote(json: [String : Any].init())
            userNote?.noteId = note.noteId
            userNote?.noteType = note.noteType
            userNote?.noteQuestionId = note.noteQuestionId
            userNote?.noteUpdatedDate = note.noteUpdatedDate!
            userNote?.note = note.note
            userNote?.isDeleted = note.isDeleted
            userNoteArr.append(userNote!)
        }
        return userNoteArr
//        notesDataModel?.userNotesArray = userNoteArr
//        return notesDataModel!
    }
    
    func saveNotesInDatabase() {
        NotesDBManager.sharedInstance.deleteAllNotesInDatabase()
        var array = [UserNoteFull]()
        let note = UserNoteFull()

        note.note = "asd"
        note.noteId = 10
        note.noteType = "personal"
        note.noteType = "personal"
        note.noteQuestionId = 4
        note.noteUpdatedDate = "aaaa aa aa"
        note.isDeleted = false

        let notesViewController = self.view as! NotesViewController
        
        var newArray = [UserNoteFull]()
        for note in notesViewController.userNotes!{
            let newNote = UserNoteFull()
            newNote.index = note.index
            newNote.noteId = note.noteId
            newNote.note = note.note
            newNote.noteQuestionId = note.noteQuestionId
            newNote.noteType = note.noteType
            newNote.noteUpdatedDate = note.noteUpdatedDate
            newNote.noteTypeEnum = note.noteTypeEnum
            newNote.isDeleted = note.isDeleted
            newArray.append(newNote)
        }
        
        array.append(contentsOf: newArray)

        NotesDBManager.sharedInstance.addArrayOfData(objects: newArray)
    }
    
    func notesInDatabase() -> [UserNoteFull] {
        return NotesDBManager.sharedInstance.getNotesFromDB()
    }
}

extension NotesPresenter: NotesPresentation {
    // TODO: implement presentation methods
}

extension NotesPresenter: NotesInteractorOutput {
    // TODO: implement interactor output methods
}
