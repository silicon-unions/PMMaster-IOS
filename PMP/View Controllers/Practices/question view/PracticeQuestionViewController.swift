//
//  PracticeQuestionViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/30/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class PracticeChoiceCell : UITableViewCell{
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class PracticeQuestionViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var iconsShadowView: UIView!
    var practiceWholeModel : PracticeWholeModel?
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    var pracicesQuestions : [PracticeQuestionFull]?
    
    var isEnglish = true
    var currentQuestion : PracticeQuestionFull?
    

    var presenter: PracticeQuestionPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter = PracticeQuestionPresenter()
        (self.presenter as! PracticeQuestionPresenter).view = self
        (self.presenter as! PracticeQuestionPresenter).questions()
        (self.presenter as! PracticeQuestionPresenter).nextQuestion()
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
        
        self.presenter = PracticeQuestionPresenter()
        (self.presenter as! PracticeQuestionPresenter).view = self
    }
    @IBAction func localize(_ sender: Any) {
        isEnglish = isEnglish ? false : true
        self.languageChanged()
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
    @IBAction func next(_ sender: Any) {
        (self.presenter as! PracticeQuestionPresenter).nextQuestion()
    }
    
    @IBAction func previous(_ sender: Any) {
        (self.presenter as! PracticeQuestionPresenter).previousQuestion()
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
    func updateTableHeight() {
        CATransaction.begin()
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        CATransaction.setCompletionBlock{[weak self] in
            self?.tableHeightConstraint.constant = (self?.tableView.contentSize.height)!
        }
        
        CATransaction.commit()
    }
    @objc func showJustification()  {
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.isOnlyOneButton = true
        alertVC.titleText = "Justification"
        alertVC.bodyText = isEnglish ? currentQuestion?.justificationE : currentQuestion?.justificationA
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
    
    func showCongratulation()  {
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.isOnlyOneButton = true
        alertVC.dialogType = .congratulations
        alertVC.titleText = "Conratulations"
        alertVC.bodyText = "You have successfully completed this level questions"
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
}

extension PracticeQuestionViewController: PracticeQuestionView {
    // TODO: implement view output methods
}

extension PracticeQuestionViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Practices"
    }
}
extension PracticeQuestionViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"PracticeCellID") as! PracticeChoiceCell
        cell.titleLabel.textAlignment = isEnglish ? .left : .right
        
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
        cell.sideView.backgroundColor = UIColor.white
        cell.infoImageView.isHidden = true
        cell.infoButton.isHidden = true
        if let currQues = currentQuestion , currQues.userAnswer.count > 0 {
            if currQues.userAnswer == "\(indexPath.row+1)" && currQues.userAnswer != currQues.correctAnswer{
                cell.sideView.backgroundColor = UIColor.PMPred
                cell.infoButton.isHidden = true
                cell.infoImageView.isHidden = true
            }else if currQues.correctAnswer == "\(indexPath.row+1)"{
                cell.sideView.backgroundColor = UIColor.PMPGreen
                cell.infoImageView.isHidden = false
                cell.infoButton.isHidden = false
                cell.infoButton.addTarget(self, action: #selector(showJustification), for: UIControlEvents.touchUpInside)
                
            }else{
                cell.sideView.backgroundColor = UIColor.white
                cell.infoButton.isHidden = true
                cell.infoImageView.isHidden = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension PracticeQuestionViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (currentQuestion?.userAnswer.count)! > 0{
            return
        }
        
        (self.presenter as! PracticeQuestionPresenter).updateQuestion(questionID: (currentQuestion?.questionId)!, userAnswer: "\(indexPath.row+1)")
        
        if currentQuestion?.correctAnswer == "\(indexPath.row+1)"{
            self.UpdateQuestionTransaction(correct: 1, wrong: 0)
        }else{
            self.UpdateQuestionTransaction(correct: 0, wrong: 1)
        }
        
//        if indexPath.row == 0{
//            currentQuestion!.userAnswer = "1"
//        }else if indexPath.row == 1{
//            currentQuestion!.userAnswer = "2"
//        }else if indexPath.row == 2{
//            currentQuestion!.userAnswer = "3"
//        }else if indexPath.row == 3{
//            currentQuestion!.userAnswer = "4"
//        }
        
//        self.tableView.isUserInteractionEnabled = false
        self.tableView.reloadData()
    }
}

extension PracticeQuestionViewController : AlertViewControllerDelegate{
    func okButtonPressed(type:DialogType){
        if type == .congratulations{
//            self.navigationController?.popViewController(animated: true)
        }
    }
    func cancelButtonPressed(type:DialogType){
        
    }
}
