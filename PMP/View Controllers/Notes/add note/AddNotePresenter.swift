//
//  AddNotePresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/26/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class AddNotePresenter {

    // MARK: Properties

    var view: AddNoteView?
    var router: AddNoteWireframe?
    var interactor: AddNoteUseCase?
    
    func callAddNote(){
        let addNoteViewController = self.view as! AddNoteViewController
        
        addNoteViewController.showSpinner()
        interactor = AddNoteInteractor()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var type : String
        if addNoteViewController.noteType == .Personal{
            type = "personal"
        }else{
            type = "question"
        }
        
        var params : [String : String] = ["note":addNoteViewController.textView.text,"updated_at" : formatter.string(from: date),"type" : type , "question_id":"13"]
        
        if let userNote = addNoteViewController.note{
            params["id"] = String("\(userNote.noteId)")
            (interactor as! AddNoteInteractor).addUpdateCall(params:params, handler: { (model, error) in
                
                if (model as! AddNoteDataModel).success!{
                    addNoteViewController.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: .updateNoteNotification, object: nil)
                }else{
                    addNoteViewController.showDefaultAlert(message: (model as! AddNoteDataModel).reason!,popView: false)
                }
                
                addNoteViewController.hideSpinner()
            
                
            })
        }else{
            (interactor as! AddNoteInteractor).addNoteCall(params:params, handler: { (model, error) in
                
                if (model as! AddNoteDataModel).success!{
                    addNoteViewController.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: .addNoteNotification, object: nil)
                }else{
                    addNoteViewController.showDefaultAlert(message: (model as! AddNoteDataModel).reason!,popView: false)
                }
                
                addNoteViewController.hideSpinner()
                
            })
        }
        
        

    }
}

extension AddNotePresenter: AddNotePresentation {
    // TODO: implement presentation methods
}

extension AddNotePresenter: AddNoteInteractorOutput {
    // TODO: implement interactor output methods
}
