//
//  OldExamViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/24/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class OldExamViewController: ExamQuestionViewController {

    // MARK: Properties
    
    var questions : [ExamQuestionFull]?
    var question : ExamQuestionFull?
    
//    override var examQuestions {
//        didSet{
//            if question == nil{
//                (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: examQuestions![0])
//            }
//            if isViewer == true{
//                return
//            }
//            if self.timerType! == .PerExam{
//                seconds = (dateComp?.hour)! * 60 * 60
//                seconds += (dateComp?.minute)! * 60
//                self.startTimer()
//            }
//        }
//    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        self.examQuestions = questions
//        (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: examQuestions![0])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let questionToShow = question{
            (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: questionToShow)
        }
    }
    
    override func setupView() {
        
        self.flagButton.isHidden = true
        self.noteButton.isHidden = true
        self.reportButton.isHidden = true
        self.listButton.isHidden = true
        self.localizationButton.isHidden = false
        
//        self.tableView.isUserInteractionEnabled = false
        
        shadowView.layer.cornerRadius = 15.0
        shadowView.layer.borderWidth = 0.5
        shadowView.layer.borderColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 3.0
        shadowView.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        
        iconsShadowView.layer.cornerRadius = 15.0
        iconsShadowView.layer.borderWidth = 0.5
        iconsShadowView.layer.borderColor = UIColor.lightGray.cgColor
        iconsShadowView.layer.shadowColor = UIColor.black.cgColor
        iconsShadowView.layer.shadowOpacity = 0.5
        iconsShadowView.layer.shadowRadius = 3.0
        iconsShadowView.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
        
        self.questionLabel.text = "loading..."
        
        self.presenter = ExamQuestionPresenter()
        (self.presenter as! ExamQuestionPresenter).view = self
        
        tableView.register(UINib(nibName: "OldExamTableViewCell", bundle: nil), forCellReuseIdentifier: "OldExamTableViewCell")
    }
    
    override func nextQuestion(_ sender: Any) {
        if (currentQuestion?.questionIndex)! + 1 < examQuestions!.count{
            (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: examQuestions![(currentQuestion?.questionIndex)! + 1])
        }
    }
    
//    func spreadQuestion(question:ExamQuestionFull) {
//        let examQuestionViewController = self.view as! ExamQuestionViewController
//        if question.isFlagged{
//            examQuestionViewController.flagButton.isSelected = true
//        }else{
//            examQuestionViewController.flagButton.isSelected = false
//        }
//        
//        examQuestionViewController.questionLabel.text = examQuestionViewController.isEnglish ? question.questionE : question.questionA
//        
//        examQuestionViewController.updateTableHeight()
//    }
    
    @objc func showJustification() {
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.isOnlyOneButton = true
        alertVC.titleText = "Justification"
        alertVC.bodyText = isEnglish ? currentQuestion?.justificationE : currentQuestion?.justificationA
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"OldExamTableViewCell") as! OldExamTableViewCell
        
        cell.titleLabel.textAlignment = isEnglish ? .left : .right
        
        cell.infoButton.addTarget(self, action: #selector(showJustification), for: UIControlEvents.touchUpInside)
        
        if let currentQues = currentQuestion{
            if indexPath.row == 0{
                cell.titleLabel.text = isEnglish ?currentQues.answerE1 : currentQues.answerA1
            }else if indexPath.row == 1{
                cell.titleLabel.text = isEnglish ?currentQues.answerE2 : currentQues.answerA2
            }else if indexPath.row == 2{
                cell.titleLabel.text = isEnglish ?currentQues.answerE3 : currentQues.answerA3
            }else if indexPath.row == 3{
                cell.titleLabel.text = isEnglish ?currentQues.answerE4 : currentQues.answerA4
            }
        }else{
            cell.titleLabel.text = "loading..."
        }
        if let currQues = currentQuestion{
            if indexPath.row == 0{
                if currQues.userAnswer == "1"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                }
                if currQues.correctAnswer == "1"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                    
                }else if currQues.userAnswer != "1" && currQues.correctAnswer != "1"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
//                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }else if indexPath.row == 1{
                if currQues.userAnswer == "2"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                    
                }
                if currQues.correctAnswer == "2"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                }else if currQues.userAnswer != "2" && currQues.correctAnswer != "2"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
//                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }else if indexPath.row == 2{
                if currQues.userAnswer == "3"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                }
                if currQues.correctAnswer == "3"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                }else if currQues.userAnswer != "3" && currQues.correctAnswer != "3"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
//                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }else if indexPath.row == 3{
                if currQues.userAnswer == "4"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                }
                if currQues.correctAnswer == "4"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                }else if currQues.userAnswer != "4" && currQues.correctAnswer != "4"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
//                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }
        }
        
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension OldExamViewController: OldExamView {
    // TODO: implement view output methods
}


    


