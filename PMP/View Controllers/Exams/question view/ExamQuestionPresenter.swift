//
//  ExamQuestionPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamQuestionPresenter {

    // MARK: Properties

    var view: ExamQuestionView?
    var router: ExamQuestionWireframe?
    var interactor: ExamQuestionUseCase?
    var examQuesViewModel = ExamQuestionViewModel()
    
    
    func callExam(){
        let examQuestionViewController = self.view as! ExamQuestionViewController
        
        examQuestionViewController.showSpinner()
        interactor = ExamQuestionInteractor()
        (interactor as! ExamQuestionInteractor).callExam(params: ["numberOfQuestions":"\(examQuestionViewController.numberOfQuestions!)"],handler: { (model, error) in
            if error != nil {
                (self.view as! ProfileViewController).showDefaultAlert(message: (error?.localizedDescription)!, popView: true)
            }
            guard let success = (model as! ExamQuestionDataModel).success else{
                return
            }
                
            if success{
                print(model!)
                
                self.prepareViewModel(dataModel: (model as! ExamQuestionDataModel))
                examQuestionViewController.examQuestions = self.examQuesViewModel.examQuestions
                
            }else{
                (self.view as! ProfileViewController).showDefaultAlert(message: (model as! ExamQuestionDataModel).reason!,popView: false)
            }
            
            examQuestionViewController.hideSpinner()
            
        })
    }
    
    func prepareViewModel(dataModel:ExamQuestionDataModel){
        var index = -1
        for question in dataModel.examQuestionsModelArray!{
            index += 1
            
            let examQuesFull = ExamQuestionFull()
            examQuesFull.questionId = question.questionId!
            examQuesFull.questionE = question.questionE
            examQuesFull.questionA = question.questionA
            
            examQuesFull.answerE1 = question.answerE1
            examQuesFull.answerE2 = question.answerE2
            examQuesFull.answerE3 = question.answerE3
            examQuesFull.answerE4 = question.answerE4
            
            examQuesFull.answerA1 = question.answerA1
            examQuesFull.answerA2 = question.answerA2
            examQuesFull.answerA3 = question.answerA3
            examQuesFull.answerA4 = question.answerA4
            
            examQuesFull.correctAnswer = question.correctAnswer
            examQuesFull.processGroup = question.processGroup
            examQuesFull.knowledgeArea = question.knowledgeArea
            
            examQuesFull.level = question.level
            examQuesFull.justificationE = question.justificationE
            examQuesFull.justificationA = question.justificationA
            
            examQuesFull.timeRemainig = 18
            if let examQuestionViewController = self.view as? ExamQuestionViewController{
                examQuesFull.timeRemainig = (examQuestionViewController.dateComp?.hour)! * 60 * 60
                examQuesFull.timeRemainig += (examQuestionViewController.dateComp?.minute)! * 60
            }
            examQuesFull.questionIndex = index
            
            examQuesViewModel.examQuestions.append(examQuesFull)
        }   
    }
    
    func spreadQuestion(question:ExamQuestionFull) {
        let examQuestionViewController = self.view as! ExamQuestionViewController
        if question.isFlagged{
            examQuestionViewController.flagButton.isSelected = true
        }else{
            examQuestionViewController.flagButton.isSelected = false
        }
        
        if examQuestionViewController.timerType != nil{
            if examQuestionViewController.timerType! == .PerQuestion{
                self.saveStateOfCurrentQuestion()
                examQuestionViewController.currentQuestion = question
                examQuestionViewController.timer.invalidate()
                if question.timeRemainig > 0{
                    examQuestionViewController.tableView.isUserInteractionEnabled = true
                    examQuestionViewController.seconds = question.timeRemainig + examQuestionViewController.oneSecond
                    examQuestionViewController.startTimer()
                }else{
                    examQuestionViewController.tableView.isUserInteractionEnabled = false
                    examQuestionViewController.seconds = question.timeRemainig
                    examQuestionViewController.timerLabel.text = self.timeString(time: TimeInterval.init(0))
                }
            }else{
                examQuestionViewController.currentQuestion = question
            }
        }else{
            examQuestionViewController.currentQuestion = question
        }
        
        examQuestionViewController.questionLabel.text =  examQuestionViewController.isEnglish ? "\(question.questionIndex + 1)-" + question.questionE! : "\(question.questionIndex + 1)-" + question.questionA!
        
//        examQuestionViewController.tableView.reloadData()
        examQuestionViewController.updateTableHeight()
    }
    
    func saveStateOfCurrentQuestion(){
        let examQuestionViewController = self.view as! ExamQuestionViewController
        if let currentQues = examQuestionViewController.currentQuestion{
            currentQues.timeRemainig = examQuestionViewController.seconds
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i",hours , minutes, seconds)
    }
}

extension ExamQuestionPresenter: ExamQuestionPresentation {
    // TODO: implement presentation methods
}

extension ExamQuestionPresenter: ExamQuestionInteractorOutput {
    // TODO: implement interactor output methods
}
