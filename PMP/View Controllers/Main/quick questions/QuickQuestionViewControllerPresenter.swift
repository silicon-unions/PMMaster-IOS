//
//  QuickQuestionViewControllerPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/29/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class QuickQuestionViewControllerPresenter {

    // MARK: Properties

    var view: QuickQuestionViewControllerView?
    var router: QuickQuestionViewControllerWireframe?
    var interactor: QuickQuestionViewControllerUseCase?
    
    
    func spreadQuestion(question:PracticeQuestionFull) {
        let quickQuestionViewController = self.view as! QuickQuestionViewControllerViewController
        quickQuestionViewController.currentQuestion = question
        quickQuestionViewController.questionLabel.text = quickQuestionViewController.isEnglish ? question.questionE : question.questionA
        
        //        examQuestionViewController.tableView.reloadData()
        quickQuestionViewController.updateTableHeight()
    }
}

extension QuickQuestionViewControllerPresenter: QuickQuestionViewControllerPresentation {
    // TODO: implement presentation methods
}

extension QuickQuestionViewControllerPresenter: QuickQuestionViewControllerInteractorOutput {
    // TODO: implement interactor output methods
}
