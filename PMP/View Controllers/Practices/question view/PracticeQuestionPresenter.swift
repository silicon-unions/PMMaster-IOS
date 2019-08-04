//
//  PracticeQuestionPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/30/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class PracticeQuestionPresenter {

    // MARK: Properties

    var view: PracticeQuestionView?
    var router: PracticeQuestionWireframe?
    var interactor: PracticeQuestionUseCase?
    var i = -1
    
    func questions(){
        let practiceQuestionViewController = self.view as! PracticeQuestionViewController
        let practiceModel = practiceQuestionViewController.practiceWholeModel
        
        if practiceModel?.practiceType == .knowledgeArea{
            practiceQuestionViewController.pracicesQuestions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(practiceModel!.level!)' AND knowledgeArea = [c]'\((practiceModel!.knowledgeArea?.rawValue)!)' AND correctAnswer != userAnswer")
            
            for question in practiceQuestionViewController.pracicesQuestions!{
                self.updateQuestion(questionID: question.questionId, userAnswer: "")
            }
            
        }else{
            practiceQuestionViewController.pracicesQuestions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(practiceModel!.level!)' AND processGroup = [c]'\((practiceModel!.processGroup?.rawValue)!)' AND correctAnswer != userAnswer")
            
            for question in practiceQuestionViewController.pracicesQuestions!{
                self.updateQuestion(questionID: question.questionId, userAnswer: "")
            }
        }
//        if (practiceQuestionViewController.pracicesQuestions?.count)! == 0{
//            let defaults:UserDefaults = UserDefaults.standard
//            if practiceModel?.practiceType == .knowledgeArea{
//                defaults.set("\(practiceModel!.level!)", forKey: "\((practiceModel!.knowledgeArea?.rawValue)!)")
//            }else{
//                defaults.set("\(practiceModel!.level!)", forKey: "\((practiceModel!.processGroup?.rawValue)!)")
//            }
//
//            practiceQuestionViewController.showCongratulation()
//            practiceQuestionViewController.navigationController?.popViewController(animated: false)
//            return
//        }
    }
    
    func restOfQuestions() -> [PracticeQuestionFull]{
        let practiceQuestionViewController = self.view as! PracticeQuestionViewController
        let practiceModel = practiceQuestionViewController.practiceWholeModel
        
        if practiceModel?.practiceType == .knowledgeArea{
            let questions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(practiceModel!.level!)' AND knowledgeArea = [c]'\((practiceModel!.knowledgeArea?.rawValue)!)' AND correctAnswer != userAnswer")
            for question in questions{
                self.updateQuestion(questionID: question.questionId, userAnswer: "")
            }
            return questions
        }else{
            let questions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(practiceModel!.level!)' AND processGroup = [c]'\((practiceModel!.processGroup?.rawValue)!)' AND correctAnswer != userAnswer")
            for question in questions{
                self.updateQuestion(questionID: question.questionId, userAnswer: "")
            }
            return questions
        }
    }
    
    func nextQuestion() {
        self.checkCurrentLevel()
        
        let practiceQuestionViewController = self.view as! PracticeQuestionViewController
        if i >= (practiceQuestionViewController.pracicesQuestions?.count)! - 1{
            if self.currentLevel() == practiceQuestionViewController.practiceWholeModel?.level{
                practiceQuestionViewController.pracicesQuestions?.append(contentsOf: self.restOfQuestions())
            }else{
                NotificationCenter.default.post(name: .showCongratulationsNotification, object: nil)
                return
            }
        }
        
        i = i + 1
        if (practiceQuestionViewController.pracicesQuestions?.count)! >= i && (practiceQuestionViewController.pracicesQuestions?.count)! != 0 {
            let question = practiceQuestionViewController.pracicesQuestions![i]
            practiceQuestionViewController.currentQuestion = question
            practiceQuestionViewController.questionLabel.text = practiceQuestionViewController.isEnglish ? question.questionE : question.questionA

            practiceQuestionViewController.updateTableHeight()
        }
        
    }
    
    func previousQuestion() {
        if i == 0 {
            return
        }
        i = i - 1
        let practiceQuestionViewController = self.view as! PracticeQuestionViewController
        
        if i >= 0 {
            let question = practiceQuestionViewController.pracicesQuestions![i]
            practiceQuestionViewController.currentQuestion = question
            practiceQuestionViewController.questionLabel.text = practiceQuestionViewController.isEnglish ? question.questionE : question.questionA
            
            practiceQuestionViewController.updateTableHeight()
        }
        
    }
    
    func checkCurrentLevel()  {
        let practiceQuestionViewController = self.view as! PracticeQuestionViewController
        let practiceModel = practiceQuestionViewController.practiceWholeModel
        let defaults:UserDefaults = UserDefaults.standard
        
        if practiceModel?.practiceType == .knowledgeArea{
            let questions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(practiceModel!.level!)' AND knowledgeArea = [c]'\((practiceModel!.knowledgeArea?.rawValue)!)' AND correctAnswer != userAnswer")
            if questions.count == 0 {
                defaults.set("\(practiceModel!.level!+1)", forKey: "\((practiceModel!.knowledgeArea?.rawValue)!)")
            }
        }else{
            let questions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(practiceModel!.level!)' AND processGroup = [c]'\((practiceModel!.processGroup?.rawValue)!)' AND correctAnswer != userAnswer")
            if questions.count == 0 {
                defaults.set("\(practiceModel!.level!+1)", forKey: "\((practiceModel!.processGroup?.rawValue)!)")
            }
        }
    }
    
    func currentLevel() -> Int{
        let defaults:UserDefaults = UserDefaults.standard
        let practiceLevelsViewController = self.view as! PracticeQuestionViewController
        if practiceLevelsViewController.practiceWholeModel?.practiceType == .knowledgeArea{
            return(Int(defaults.string(forKey: (practiceLevelsViewController.practiceWholeModel?.knowledgeArea!.rawValue)!)!))!
        }else{
            return(Int(defaults.string(forKey: (practiceLevelsViewController.practiceWholeModel?.processGroup!.rawValue)!)!))!
        }
    }
    
    func updateQuestion(questionID : Int,userAnswer:String) {
//        var updatedQuestion = PracticesDBManager.sharedInstance.filterData(filterSyntax: "questionId = \(questionID)")[0]
        PracticesDBManager.sharedInstance.updateData(questionID: "\(questionID)", userAnswer: userAnswer)
    }
}

extension PracticeQuestionPresenter: PracticeQuestionPresentation {
    // TODO: implement presentation methods
}

extension PracticeQuestionPresenter: PracticeQuestionInteractorOutput {
    // TODO: implement interactor output methods
}
