//
//  ChartCollectionViewCell.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/2/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import RKPieChart

class ChartCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var chartView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 15.0
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)

        let allCount : Double = Double(PracticesDBManager.sharedInstance.getDataFromDB().count)
        let correctCount : Double = Double(PracticesDBManager.sharedInstance.filterData(filterSyntax: "correctAnswer = userAnswer").count)
        let percentage : Double = Double(correctCount/allCount * 100)
        let percentageString = "\(String(format: "%.1f", percentage))%"
        
        let firstItem: RKPieChartItem = RKPieChartItem(ratio: 50, color: UIColor.orange, title: "Correct answers: \(correctCount)")
        let secondItem: RKPieChartItem = RKPieChartItem(ratio: 30, color: UIColor.gray, title: "Wrong answers: \(allCount - correctCount)")
        let thirdItem: RKPieChartItem = RKPieChartItem(ratio: 20, color: UIColor.yellow, title: "total questions: \(allCount)")

        let title = percentageString + "\nis your total current pecentage"
        let attributes = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 28)]
        let attTitle = NSMutableAttributedString(string: title)
        attTitle.addAttributes(attributes, range: NSRange.init(location: 0, length: percentageString.count))
        attTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 9), range: NSRange.init(location: percentageString.count, length: "\nis your total current pecentage".count))
        
        let chart = RKPieChartView(items: [firstItem, secondItem, thirdItem], centerTitle: attTitle)
        chart.circleColor = .clear
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.arcWidth = 20
        chart.isIntensityActivated = false
        chart.style = .butt
        chart.isTitleViewHidden = false
        chart.isAnimationActivated = true
        self.chartView.addSubview(chart)

        self.chartView.addConstraints([
            NSLayoutConstraint(item: chart, attribute: .leading, relatedBy: .equal, toItem: chartView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .trailing, relatedBy: .equal, toItem: chartView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .top, relatedBy: .equal, toItem: chartView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .bottom, relatedBy: .equal, toItem: chartView, attribute: .bottom, multiplier: 1.0, constant: 0),
            ])
    }
}
