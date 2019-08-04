//
//  NotesRouter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/19/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class NotesRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> NotesViewController {
        let viewController = UIStoryboard.loadViewController() as NotesViewController
        let presenter = NotesPresenter()
        let router = NotesRouter()
        let interactor = NotesInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    
    static func presentAddNote(view : UIViewController){
        let addNoteViewController = AddNoteRouter.setupModule()
        addNoteViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        if (view as? NotesViewController)?.selectedIndex == 0{
            addNoteViewController.noteType = .Personal
        }else{
            addNoteViewController.noteType = .Question
        }
        addNoteViewController.notesCount = ((view as! NotesViewController).userNotes?.count)!
        view.navigationController?.present(addNoteViewController, animated: true, completion: nil)
    }
    
    static func presentUpdateNote(view : UIViewController,userNote:UserNoteFull){
        let addNoteViewController = AddNoteRouter.setupModule()
        addNoteViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        if (view as? NotesViewController)?.selectedIndex == 0{
            addNoteViewController.noteType = .Personal
        }else{
            addNoteViewController.noteType = .Question
        }
        addNoteViewController.note = userNote
        view.navigationController?.present(addNoteViewController, animated: true, completion: nil)
    }
    
}

extension NotesRouter: NotesWireframe {
    // TODO: Implement wireframe methods
}
