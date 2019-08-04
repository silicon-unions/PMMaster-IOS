//
//  ExamStatisticesViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/20/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import RKPieChart

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class ExamStatisticesViewController: BaseViewController {

    // MARK: Properties

    var examQuestions : [ExamQuestionFull]?
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var chartContainer: UIView!
    
    var presenter: ExamStatisticesPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawChart()
        
        let exam = Exam()
        exam.examId = ExamsDBManager.sharedInstance.getExamsFromDB().count
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
        exam.examTime = formatter.string(from: date)
        exam.examQuestions.append(objectsIn: examQuestions!)
        
        ExamsDBManager.sharedInstance.addData(object: exam)
    }
    
    func drawChart() {
        
        shadowView.layer.cornerRadius = 15.0
        shadowView.layer.borderWidth = 0.5
        shadowView.layer.borderColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 3.0
        shadowView.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        
        let allCount = self.examQuestions?.count
        let correctCount = self.calStatusQues().correct
        let wrongCount = self.calStatusQues().wrong
        let percentage : Double = Double(Double(correctCount)/Double(allCount!) * 100)
        let wrongPercentage : Double = Double(Double(wrongCount)/Double(allCount!) * 100)
        let percentageString = "\(String(format: "%.1f", percentage))%"
        
        let firstItem: RKPieChartItem = RKPieChartItem(ratio: 0, color: UIColor.lightGray, title: "All questions: \(allCount!)")
        let secondItem: RKPieChartItem = RKPieChartItem(ratio: uint(percentage), color: UIColor.PMPNewBlue, title: "Correct answers: \(correctCount)")
        let thirdItem: RKPieChartItem = RKPieChartItem(ratio: uint(wrongPercentage), color: UIColor.PMPYellow, title: "Wrong answers: \(allCount! - correctCount)")
        
        
        let title = "Your\nResults"
        let attributes = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 22) , NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        let attTitle = NSMutableAttributedString(string: title)
        attTitle.addAttributes(attributes, range: NSRange.init(location: 0, length: title.count))
        
        let chart = RKPieChartView(items: [/*thirdItem,*/ firstItem, secondItem , thirdItem], centerTitle: attTitle)
        chart.circleColor = .lightGray
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.arcWidth = 20
        chart.isIntensityActivated = false
        chart.style = .butt
        chart.isTitleViewHidden = false
        chart.isAnimationActivated = true
        self.chartContainer.addSubview(chart)
        
        self.chartContainer.addConstraints([
            NSLayoutConstraint(item: chart, attribute: .leading, relatedBy: .equal, toItem: chartContainer, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .trailing, relatedBy: .equal, toItem: chartContainer, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .top, relatedBy: .equal, toItem: chartContainer, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .bottom, relatedBy: .equal, toItem: chartContainer, attribute: .bottom, multiplier: 1.0, constant: 0),
            ])
    }
    
    
    func calStatusQues() -> (correct: Int , wrong: Int) {
        var correctNumber = 0
        var wrongNumber = 0
        for question in examQuestions!{
            if question.correctAnswer == question.userAnswer{
                correctNumber += 1
            }else{
                wrongNumber += 1
            }
        }
        return (correctNumber,wrongNumber)
    }
    
    @IBAction func done() {
        MainViewRouter.popToHome(navController: self.navigationController!)
    }
    @IBAction func review(_ sender: Any) {
        let examResultVC = ExamResultRouter.setupModule()
        examResultVC.examQuestions = self.examQuestions
        self.navigationController?.pushViewController(examResultVC, animated: true)
    }
}

extension ExamStatisticesViewController: ExamStatisticesView {
    // TODO: implement view output methods
}

extension ExamStatisticesViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Exam"
    }
}
