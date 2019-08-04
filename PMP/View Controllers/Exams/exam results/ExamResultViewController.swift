//
//  ExamResultViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/11/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ExamResultCell : UITableViewCell{
    
    @IBOutlet weak var infoButton : UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class ExamResultViewController: BaseViewController {

    // MARK: Properties
    var presenter: ExamResultPresentation?
    @IBOutlet weak var tableView: UITableView!
    
    var examQuestions : [ExamQuestionFull]? {
        didSet{
            let exam = Exam()
            exam.examId = ExamsDBManager.sharedInstance.getExamsFromDB().count
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
            exam.examTime = formatter.string(from: date)
            exam.examQuestions.append(objectsIn: examQuestions!)

            ExamsDBManager.sharedInstance.addData(object: exam)
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton

    }
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        MainViewRouter.popToHome(navController: self.navigationController!)
    }
    
    @objc func showStatistices(){
        let statisticesVC = ExamStatisticesRouter.setupModule()
        statisticesVC.examQuestions = self.examQuestions
        self.navigationController?.pushViewController(statisticesVC, animated: true)
    }
    
    @objc func showJustification(_ sender: Any) {
        let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertVC.isOnlyOneButton = true
        alertVC.titleText = "Justification"
        alertVC.bodyText = examQuestions![(sender as! UIButton).tag].justificationE
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
}

extension ExamResultViewController: ExamResultView {
    // TODO: implement view output methods
}

extension ExamResultViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Exam"
    }
}

extension ExamResultViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let examQuess = examQuestions{
            return examQuess.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ExamResultCellID") as? ExamResultCell
        cell?.infoButton.tag = indexPath.row
        cell?.infoButton.addTarget(self, action: #selector(showJustification), for: UIControlEvents.touchUpInside)
        
        cell?.titleLabel.text = examQuestions![indexPath.row].questionE
        if examQuestions![indexPath.row].userAnswer.count > 0{
            cell?.subtitleLabel.text = "Answer: " + examQuestions![indexPath.row].userAnswer
        }else{
            cell?.subtitleLabel.text = "Answer: Not Answered"
        }
        if examQuestions![indexPath.row].userAnswer == examQuestions![indexPath.row].correctAnswer{
            cell?.statusLabel.text = "CORRECT"
            cell?.statusLabel.textColor = UIColor.green
        }else{
            cell?.statusLabel.text = "NOT CORRECT"
            cell?.statusLabel.textColor = UIColor.red
        }
        if examQuestions![indexPath.row].isFlagged {
            cell?.flagImageView.isHidden = false
        }else{
            cell?.flagImageView.isHidden = true
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension ExamResultViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "Exam", bundle: nil)
        let oldExamVC = storyboard.instantiateViewController(withIdentifier :"OldExamViewController") as! OldExamViewController
        oldExamVC.questions = self.examQuestions
        oldExamVC.isViewer = true
        oldExamVC.question = self.examQuestions?[indexPath.row]
        self.navigationController?.pushViewController(oldExamVC, animated: true)
    }
}
