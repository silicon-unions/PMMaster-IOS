//
//  NotesViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/19/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit


extension Notification.Name {
    static let addNoteNotification = Notification.Name("addNoteNotification")
    static let updateNoteNotification = Notification.Name("updateNoteNotification")
    static let deleteNoteNotification = Notification.Name("deleteNoteNotification")
}

class NotesViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var personalNotesView: UIView!
    @IBOutlet weak var questionNotesView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var personalNotesLabel: UILabel!
    @IBOutlet weak var questionNotesLAbel: UILabel!
    var selectedNoteTodeleteIndex = -1
    
    var selectedIndex = 0
    var userNotes : Array<UserNoteFull>? = nil {
        didSet{
            self.classifyNotesTypes()
        }
    }
    
    var personalUserNotes : Array<UserNoteFull> = []
    var questionUserNotes : Array<UserNoteFull> = []
    
    
    var presenter: NotesPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = NotesPresenter()
        (presenter as! NotesPresenter).view = self
        (presenter as! NotesPresenter).callUserNotes()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNote), name: .addNoteNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNote), name: .updateNoteNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote), name: .deleteNoteNotification, object: nil)
        
        tableView.register(UINib(nibName: AskInstructorTableViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: AskInstructorTableViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.showPersonalNotes(UIButton.init())
        
        addButton.addTarget(self, action: #selector(submitButtonPressed), for: UIControlEvents.touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func addNote(not: Notification) {
//        (presenter as! NotesPresenter).callUserNotes()
//        if let userInfo = not.userInfo {
//            // Safely unwrap the name sent out by the notification sender
//            if let note = userInfo["note"] as? UserNoteFull {
//                NotesDBManager.sharedInstance.deleteAllDatabase()
//                self.userNotes?.append(note)
//                self.tableView.reloadData()
//            }
//        }
//        (self.presenter as! NotesPresenter).saveNotesInDatabase()
        
        self.userNotes = NotesDBManager.sharedInstance.getNotesFromDB()
        self.tableView.reloadData()
    }
    @objc func updateNote(not: Notification) {
//        (presenter as! NotesPresenter).callUserNotes()
//        if let userInfo = not.userInfo {
//            // Safely unwrap the name sent out by the notification sender
//            if let updatednote = userInfo["note"] as? UserNoteFull {
//                for note in self.userNotes!{
//                    if note.noteId == updatednote.noteId{
//                        NotesDBManager.sharedInstance.deleteAllDatabase()
//                        note.note = updatednote.note
//                        note.isDeleted = updatednote.isDeleted
//                    }
//                }
        self.userNotes = NotesDBManager.sharedInstance.getNotesFromDB()
                self.tableView.reloadData()
//                (self.presenter as! NotesPresenter).saveNotesInDatabase()
//            }
//        }
    }
    @objc func deleteNote(sender : UIButton) {
        self.selectedNoteTodeleteIndex = sender.tag
        
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.isOnlyOneButton = false
        alertVC.titleText = "Are you sure"
        alertVC.bodyText = "Delete this note"
        alertVC.delegate = self
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
    
    
    @objc func submitButtonPressed(){
        NotesRouter.presentAddNote(view: self)
    }
    
    @IBAction func showPersonalNotes(_ sender: Any) {
        self.addView.isHidden = false
        selectedIndex = 0
        self.personalNotesView.backgroundColor = UIColor.PMPNewBlue
        self.questionNotesView.backgroundColor = UIColor.white
        
        self.personalNotesLabel.textColor = UIColor.white
        self.questionNotesLAbel.textColor = UIColor.darkGray
        
        
        self.tableView.reloadData()
    }
    @IBAction func showQuestionNotes(_ sender: Any) {
        self.addView.isHidden = true
        selectedIndex = 1
        
        self.questionNotesView.backgroundColor = UIColor.PMPNewBlue
        self.personalNotesView.backgroundColor = UIColor.white
        
        self.questionNotesLAbel.textColor = UIColor.white
        self.personalNotesLabel.textColor = UIColor.darkGray
        
        self.tableView.reloadData()
    }
    
    func classifyNotesTypes(){
        personalUserNotes.removeAll()
        questionUserNotes.removeAll()
        var i = -1
        
        for userNote in userNotes!{
//            if userNote.isDeleted == false{
//                i+=1
//                userNote.index = i
//            }
            if userNote.noteType == "personal" && userNote.isDeleted != true{
                personalUserNotes.append(userNote)
            }else if userNote.noteType == "question" && userNote.isDeleted != true{
                questionUserNotes.append(userNote)
            }
        }
        self.tableView.reloadData()
    }
}

extension NotesViewController: NotesView {
    // TODO: implement view output methods
}

extension NotesViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "PMPNotes"
    }
}

extension NotesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 0 {
            return personalUserNotes.count
        }else{
            return questionUserNotes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AskInstructorTableViewCell.identifier) as! AskInstructorTableViewCell
        if selectedIndex == 0 {
            cell.configureCell(userNote: personalUserNotes[indexPath.row])
            cell.deleteButton.tag = indexPath.row
        }else{
            cell.configureCell(userNote: questionUserNotes[indexPath.row])
            cell.deleteButton.tag = indexPath.row
        }
        
        cell.deleteButton.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        
        return cell
    }
}
extension NotesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if selectedIndex == 0{
            NotesRouter.presentUpdateNote(view: self, userNote: personalUserNotes[indexPath.row])
        }else{
            NotesRouter.presentUpdateNote(view: self, userNote: questionUserNotes[indexPath.row])
        }
        
    }
}

extension NotesViewController : AlertViewControllerDelegate{
    func okButtonPressed(type:DialogType){
        
        if selectedIndex == 0{
            let note = self.personalUserNotes[selectedNoteTodeleteIndex]
            NotesDBManager.sharedInstance.deleteData(object: note)
        }else{
            let note = self.questionUserNotes[selectedNoteTodeleteIndex]
            NotesDBManager.sharedInstance.deleteData(object: note)
        }
        
        self.userNotes = NotesDBManager.sharedInstance.getNotesFromDB()
        self.tableView.reloadData()
    }
    func cancelButtonPressed(type:DialogType){
        
    }
}
