//
//  AddNoteViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/26/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class AddNoteViewController: BaseViewController {

    // MARK: Properties

    var note : UserNoteFull?
    var notesCount : Int = 0
    var noteType : NoteType = .Personal
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    var presenter: AddNotePresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        self.presenter = AddNotePresenter()
        (presenter as! AddNotePresenter).view = self
        
        if note != nil{
            addButton.setTitle("UPDATE", for: .normal)
            titleLabel.text = "Note Detail"
            textView.text = note?.note
            
            if note?.noteType == "question"{
                if let questionNote = note?.noteQuestion{
                    self.textView.text = questionNote
                    self.answerTextView.text = note?.note
                    
                    self.textView.isEditable = false
                    self.textView.isSelectable = false
                    self.textView.font = UIFont.boldSystemFont(ofSize: 14)
                    
                    self.answerTextView.isEditable = true
                    self.answerTextView.isSelectable = true
                }
            }
        }
    }
    
    @IBAction func addNote(_ sender: Any) {
//        (presenter as! AddNotePresenter).callAddNote()
        if note != nil{
            let updatedNote = UserNoteFull()
            updatedNote.index = self.notesCount
            updatedNote.noteId = (note?.noteId)!
            updatedNote.noteQuestionId = (note?.noteQuestionId)!
            updatedNote.note = self.textView.text
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
            updatedNote.noteUpdatedDate = formatter.string(from: date)
            updatedNote.noteType = (note?.noteType)!
            if note?.noteType == "question"{
                if let questionNote = note?.noteQuestion{
                    updatedNote.noteQuestion = questionNote
                }
            }
            
            NotesDBManager.sharedInstance.updateData(object: updatedNote)

            NotificationCenter.default.post(name: .updateNoteNotification, object: self, userInfo: nil)
            self.dismiss(animated: true, completion: nil)
        }else{
            
            let newNote = UserNoteFull()
            newNote.index = self.notesCount
            newNote.noteId = 0
            newNote.noteQuestionId = 0
            newNote.note = textView.text
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
            newNote.noteUpdatedDate = formatter.string(from: date)
            if noteType == .Personal{
                newNote.noteType = "personal"
            }else{
                newNote.noteType = "question"
            }
            
            NotesDBManager.sharedInstance.addData(object: newNote)
            
            NotificationCenter.default.post(name: .addNoteNotification, object: self, userInfo: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddNoteViewController: AddNoteView {
    // TODO: implement view output methods
}

extension AddNoteViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "PMPNotes"
    }
}
