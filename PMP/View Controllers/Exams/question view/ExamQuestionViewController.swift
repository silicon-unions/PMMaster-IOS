//
//  ExamQuestionViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamQuestionViewController: BaseViewController {

    // MARK: Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconsShadowView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var localizationButton: UIButton!
    
    var presenter: ExamQuestionPresentation?
    var timer = Timer()
    var timeRemaining = 0
    let oneSecond = 1
    var seconds = 0
    var timerType : TimerType?
    var dateComp : DateComponents?
    var numberOfQuestions : Int?
    var currentQuestion : ExamQuestionFull?
    var answerSelectedIndex : Int = -1
    var isEnglish = true
    var isViewer = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var examQuestions : [ExamQuestionFull]? {
        didSet{
//            DBManager.sharedInstance.addArrayOfData(objects: examQuestions!)
            (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: examQuestions![0])
            if isViewer == true{
                return
            }
            if self.timerType! == .PerExam{
                seconds = (dateComp?.hour)! * 60 * 60
                seconds += (dateComp?.minute)! * 60
                self.startTimer()
            }
        }
    }
    // MARK: Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateTableHeight()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.timer.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        
        
        //tableView.semanticContentAttribute = .forceRightToLeft
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
    }
    
    @IBAction func setupQuesLanguage(_ sender: Any) {
        isEnglish = isEnglish ? false : true
        self.languageChanged()
    }
    @IBAction func back(_ sender: Any) {
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.delegate = self
        alertVC.bodyText = "Are you sure you want to exit the exam"
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertVC.dialogType = .confirmBack
        self.navigationController?.present(alertVC, animated: true, completion: nil)
        
    }
    
    func languageChanged() {
        if isEnglish{
            tableView.semanticContentAttribute = .forceLeftToRight
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            self.questionLabel.text = "\((currentQuestion?.questionIndex)!+1)-" + (currentQuestion?.questionE)!
            self.questionLabel.textAlignment = NSTextAlignment.left
        }else{
            tableView.semanticContentAttribute = .forceRightToLeft
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            self.questionLabel.text = "\((currentQuestion?.questionIndex)!+1)-" + (currentQuestion?.questionA)!
            self.questionLabel.textAlignment = NSTextAlignment.right
        }
        self.view.setNeedsLayout()
        self.view.setNeedsDisplay()
        self.tableView.reloadData()
        self.updateTableHeight()
    }
    
    func setupView() {
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
        if appDelegate.isFreeVersion!{
            self.numberOfQuestions = -1
        }
        (self.presenter as! ExamQuestionPresenter).callExam()
//        DBManager.sharedInstance.addArrayOfData(objects: examQuestions!)
    }
    
    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            if timerType! == .PerQuestion{
                if (currentQuestion?.questionIndex)! + 1 < examQuestions!.count{
                    (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: examQuestions![(currentQuestion?.questionIndex)! + 1])
                }
            }else{
                self.tableView.isUserInteractionEnabled = false
                let examResultVC = ExamResultRouter.setupModule()
                examResultVC.examQuestions = self.examQuestions
                self.navigationController?.pushViewController(examResultVC, animated: true)
            }
            
        } else {
            seconds -= 1
        }
        timerLabel.text = (self.presenter as! ExamQuestionPresenter).timeString(time: TimeInterval(seconds))
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        if (currentQuestion?.questionIndex)! + 1 < examQuestions!.count{
            (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: examQuestions![(currentQuestion?.questionIndex)! + 1])
        }else{
            let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
            alertVC.delegate = self
            alertVC.bodyText = "Are You Sure, You Want To End And Submit Your Exam"
            alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertVC.dialogType = .submitExam
            self.navigationController?.present(alertVC, animated: true, completion: nil)
        }
    }
    @IBAction func previousQuestion(_ sender: Any) {
        if (currentQuestion?.questionIndex)! - 1 >= 0{
            (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: examQuestions![(currentQuestion?.questionIndex)! - 1])
        }
    }
    
    @IBAction func showListOfQuestions(_ sender: Any) {
        let listVC = ExamQuestionsListRouter.setupModule()
        listVC.examQuestions = self.examQuestions
        listVC.delegate = self
        self.navigationController?.present(listVC, animated: true, completion: nil)
    }
    @IBAction func report(_ sender: Any) {
        let QuestionReportVC = QuestionReportRouter.setupModule()
        QuestionReportVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        QuestionReportVC.question = currentQuestion
        self.navigationController?.present(QuestionReportVC, animated: true, completion: nil)
    }
    @IBAction func note(_ sender: Any) {
        let QuestionReportVC = QuestionReportRouter.setupModule()
        QuestionReportVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        QuestionReportVC.question = currentQuestion
        QuestionReportVC.isForReport = false
        self.navigationController?.present(QuestionReportVC, animated: true, completion: nil)
    }
    @IBAction func flag(_ sender: Any) {
        if (sender as! UIButton).isSelected{
            (sender as! UIButton).isSelected = false
            currentQuestion?.isFlagged = false
        }else{
            (sender as! UIButton).isSelected = true
            currentQuestion?.isFlagged = true
        }
    }
    
    func updateTableHeight() {
        CATransaction.begin()
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        CATransaction.setCompletionBlock{[weak self] in
            self?.view.setNeedsUpdateConstraints()
            self?.view.layoutIfNeeded()
            self?.tableHeightConstraint.constant = (self?.tableView.contentSize.height)! + 50
            self?.view.setNeedsUpdateConstraints()
            self?.view.layoutIfNeeded()
        }
        
        CATransaction.commit()
    }
    @IBAction func submit(_ sender: Any) {
        self.tableView.isUserInteractionEnabled = false
        
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.delegate = self
        alertVC.bodyText = "Are You Sure, You Want To End And Submit Your Exam"
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertVC.dialogType = .submitExam
        self.navigationController?.present(alertVC, animated: true, completion: nil)
        
//        let examResultVC = ExamResultRouter.setupModule()
//        examResultVC.examQuestions = self.examQuestions
//        self.navigationController?.pushViewController(examResultVC, animated: true)
    }
}

extension ExamQuestionViewController: ExamQuestionView {
    // TODO: implement view output methods
}

extension ExamQuestionViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Exam"
    }
}
extension ExamQuestionViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ExamCellID")
        (cell?.viewWithTag(5) as! UILabel).textAlignment = isEnglish ? .left : .right
        (cell?.viewWithTag(6) as! UIImageView).isHidden = true
        
        if let currentQues = currentQuestion{
            if indexPath.row == 0{
                (cell?.viewWithTag(5) as! UILabel).text = isEnglish ?currentQues.answerE1 : currentQues.answerA1
            }else if indexPath.row == 1{
                (cell?.viewWithTag(5) as! UILabel).text = isEnglish ?currentQues.answerE2 : currentQues.answerA2
            }else if indexPath.row == 2{
                (cell?.viewWithTag(5) as! UILabel).text = isEnglish ?currentQues.answerE3 : currentQues.answerA3
            }else if indexPath.row == 3{
                (cell?.viewWithTag(5) as! UILabel).text = isEnglish ?currentQues.answerE4 : currentQues.answerA4
            }
        }else{
            (cell?.viewWithTag(5) as! UILabel).text = "loading..."
        }
        if let currQues = currentQuestion{
            if currQues.userAnswer == "1" && indexPath.row == 0 ||
               currQues.userAnswer == "2" && indexPath.row == 1 ||
               currQues.userAnswer == "3" && indexPath.row == 2 ||
               currQues.userAnswer == "4" && indexPath.row == 3{
//                (cell?.viewWithTag(6) as! UIImageView).isHidden = false
                (cell?.viewWithTag(5) as! UILabel).textColor = UIColor.PMPGreen
            }else{
                (cell?.viewWithTag(5) as! UILabel).textColor = UIColor.darkGray
            }
        }
//        if answerSelectedIndex == indexPath.row{
//            (cell?.viewWithTag(6) as! UIImageView).isHidden = false
//        }else{
//            (cell?.viewWithTag(6) as! UIImageView).isHidden = true
//        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension ExamQuestionViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        answerSelectedIndex = indexPath.row
        if indexPath.row == 0{
            currentQuestion!.userAnswer = "1"
        }else if indexPath.row == 1{
            currentQuestion!.userAnswer = "2"
        }else if indexPath.row == 2{
            currentQuestion!.userAnswer = "3"
        }else if indexPath.row == 3{
            currentQuestion!.userAnswer = "4"
        }
        
        if currentQuestion?.correctAnswer == "\(indexPath.row+1)"{
            self.UpdateQuestionTransaction(correct: 1, wrong: 0)
        }else{
            self.UpdateQuestionTransaction(correct: 0, wrong: 1)
        }
        
        self.tableView.reloadData()
    }
}

extension ExamQuestionViewController : AlertViewControllerDelegate{
    func okButtonPressed(type:DialogType){
        if type == .submitExam{
            let examStatisticesVc = ExamStatisticesRouter.setupModule()
            examStatisticesVc.examQuestions = self.examQuestions
            self.navigationController?.pushViewController(examStatisticesVc, animated: true)
        }else if type == .confirmBack{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func cancelButtonPressed(type:DialogType){
        
    }
}

extension ExamQuestionViewController : ExamQuestionsListDelegate{
    func questionSelected(question : ExamQuestionFull){
        (self.presenter as! ExamQuestionPresenter).spreadQuestion(question: question)
    }
}
