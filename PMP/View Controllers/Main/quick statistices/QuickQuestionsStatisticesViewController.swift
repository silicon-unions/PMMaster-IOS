//
//  QuickQuestionsStatisticesViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 9/16/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import RKPieChart

class QuickQuestionsStatisticesViewController: BaseViewController {

    // MARK: Properties

    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var chartContainer: UIView!
    var correctCount : Int = 0
    
    
    var presenter: QuickQuestionsStatisticesPresentation?

    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowView.layer.cornerRadius = 15.0
        shadowView.layer.borderWidth = 0.5
        shadowView.layer.borderColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 3.0
        shadowView.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        
        self.drawChart()
    }
    
    @IBAction func done() {
        MainViewRouter.backToMainController(navController: self.navigationController!)
    }
    
    func drawChart() {
        
        
        
        let allCount = 10
        let wrongCount = 10 - self.correctCount
//        let percentage : Double = Double(Double(0)/Double(0) * 100)
        let correctPercentage : Double = Double(Double(correctCount)/Double(allCount) * 100)
        let wrongPercentage : Double = Double(Double(wrongCount)/Double(allCount) * 100)
        
        let firstItem: RKPieChartItem = RKPieChartItem(ratio: 0, color: UIColor.lightGray, title: "All questions: \(allCount)")
        let secondItem: RKPieChartItem = RKPieChartItem(ratio: uint(correctPercentage), color: UIColor.PMPNewBlue, title: "Correct answers: \(correctCount)")
        let thirdItem: RKPieChartItem = RKPieChartItem(ratio: uint(wrongPercentage), color: UIColor.PMPYellow, title: "Wrong answers: \(allCount - correctCount)")
        
        
        let title = "Your \nResults"
        let attributes = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25)]
        let attTitle = NSMutableAttributedString(string: title)
        attTitle.addAttributes(attributes, range: NSRange.init(location: 0, length: title.count))
        
        let chart = RKPieChartView(items: [firstItem, secondItem, thirdItem], centerTitle: attTitle)
        
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
}

extension QuickQuestionsStatisticesViewController: QuickQuestionsStatisticesView {
    // TODO: implement view output methods
}


extension QuickQuestionsStatisticesViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "MainView"
    }
}
