//
//  QuickQuestionViewControllerViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/29/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class QuickQuestionViewControllerViewController: BaseViewController {

    // MARK: Properties

    var presenter: QuickQuestionViewControllerPresentation?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconsShadowView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var localizationButton: UIButton!

    // MARK: Lifecycle
    var currentQuestion : PracticeQuestionFull?
    var isEnglish = true
    var questionIndex = -1
    var isNewQuestion = true
    var selectedAnswer = ""
    
    var examQuestions : [PracticeQuestionFull] = [PracticeQuestionFull]()

    override func viewDidLoad() {
        super.viewDidLoad()

//        var randomNumer = Int(arc4random_uniform(2500))
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if appDelegate.isFreeVersion!{
//            let randomNumer = Int(arc4random_uniform(2500))
//        }
        
        let list = PracticesDBManager.sharedInstance.getExamsFromDB()
        
        while (examQuestions.count) < 10 {
            
            if list.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(list.count)))
                examQuestions.append(list[randomIndex])
            }
        }
        
        self.setupView()
        
        self.nextQuestion(UIButton.init())
    }
    
    func languageChanged() {
        if isEnglish{
            tableView.semanticContentAttribute = .forceLeftToRight
            self.questionLabel.text = currentQuestion?.questionE
            self.questionLabel.textAlignment = NSTextAlignment.left
        }else{
            tableView.semanticContentAttribute = .forceRightToLeft
            self.questionLabel.text = currentQuestion?.questionA
            self.questionLabel.textAlignment = NSTextAlignment.right
        }
        self.view.setNeedsLayout()
        self.view.setNeedsDisplay()
        self.tableView.reloadData()
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
        
        self.presenter = QuickQuestionViewControllerPresenter()
        (self.presenter as! QuickQuestionViewControllerPresenter).view = self
        
        tableView.register(UINib(nibName: "OldExamTableViewCell", bundle: nil), forCellReuseIdentifier: "OldExamTableViewCell")
    }
    
    
    @IBAction func nextQuestion(_ sender: Any) {
        if questionIndex < 9{
            isNewQuestion = true
            questionIndex += 1
            (self.presenter as! QuickQuestionViewControllerPresenter).spreadQuestion(question: examQuestions[questionIndex])
            
            self.tableView.reloadData()
            self.updateTableHeight()
        }else{
            self.navigationController?.pushViewController(QuickQuestionsStatisticesRouter.setupModule(), animated: true)
        }
    }
    
    @IBAction func report(_ sender: Any) {
        let QuestionReportVC = QuestionReportRouter.setupModule()
        QuestionReportVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        QuestionReportVC.practiceQuestion = currentQuestion
        self.navigationController?.present(QuestionReportVC, animated: true, completion: nil)
    }
    @IBAction func note(_ sender: Any) {
        let QuestionReportVC = QuestionReportRouter.setupModule()
        QuestionReportVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        QuestionReportVC.practiceQuestion = currentQuestion
        QuestionReportVC.isForReport = false
        self.navigationController?.present(QuestionReportVC, animated: true, completion: nil)
    }
    
    func updateTableHeight() {
        CATransaction.begin()
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        CATransaction.setCompletionBlock{[weak self] in
            self?.tableHeightConstraint.constant = (self?.tableView.contentSize.height)! + 10
        }
        
        CATransaction.commit()
    }
    
    @objc func showJustification() {
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.isOnlyOneButton = true
        alertVC.titleText = "Justification"
        alertVC.bodyText = isEnglish ? currentQuestion?.justificationE : currentQuestion?.justificationA
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func setupQuesLanguage(_ sender: Any) {
        isEnglish = isEnglish ? false : true
        self.languageChanged()
    }
}

extension QuickQuestionViewControllerViewController: QuickQuestionViewControllerView {
    // TODO: implement view output methods
}

extension QuickQuestionViewControllerViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "MainView"
    }
}

extension QuickQuestionViewControllerViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"OldExamTableViewCell") as! OldExamTableViewCell
        
        cell.titleLabel.textAlignment = isEnglish ? .left : .right
        cell.sideView.backgroundColor = UIColor.clear
        cell.infoButton.isHidden = true
        
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
        if let currQues = currentQuestion , !isNewQuestion{
            if indexPath.row == 0{
                if selectedAnswer == "1"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                }
                if currQues.correctAnswer == "1"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                    
                }else if selectedAnswer != "1"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
                    //                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }
            if indexPath.row == 1{
                if selectedAnswer == "2"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                    
                }
                if currQues.correctAnswer == "2"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                }else if selectedAnswer != "2"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
                    //                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }
            if indexPath.row == 2{
                if selectedAnswer == "3"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                }
                if currQues.correctAnswer == "3"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                }else if selectedAnswer != "3"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
                    //                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }
            if indexPath.row == 3{
                if selectedAnswer == "4"{
                    cell.sideView.backgroundColor = UIColor.PMPred
                    cell.infoButton.isHidden = true
                }
                if currQues.correctAnswer == "4"{
                    cell.sideView.backgroundColor = UIColor.PMPGreen
                    cell.infoButton.isHidden = false
                }else if selectedAnswer != "4"{
                    cell.infoButton.isHidden = true
                    cell.sideView.backgroundColor = UIColor.clear
                    //                    cell?.answerStatusViewWidthConstraint.constant = 0
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension QuickQuestionViewControllerViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if isNewQuestion == false{
            return
        }
        isNewQuestion = false
        selectedAnswer = "\(indexPath.row + 1)"
        self.tableView.reloadData()
    }
}

