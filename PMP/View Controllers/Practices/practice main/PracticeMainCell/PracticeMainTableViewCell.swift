//
//  PracticeMainTableViewCell.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/5/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import RKPieChart
import GTProgressBar

class PracticeMainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressBar: GTProgressBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func drawChart(progress : Float) {
        progressBar.progress = CGFloat(progress)
        progressBar.barBorderColor = UIColor.white
        progressBar.barFillColor = UIColor.PMPNewBlue
        progressBar.barBackgroundColor = UIColor.lightGray
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        progressBar.displayLabel = false
        
//        progressBarLargerFont.font = UIFont.boldSystemFont(ofSize: 18)
//        progressBarLargerFont.barMaxHeight = 12
        progressBar.cornerRadius =  0.0
        
//        let firstItem: RKPieChartItem = RKPieChartItem(ratio: 50, color: UIColor.orange, title: "")
//        let secondItem: RKPieChartItem = RKPieChartItem(ratio: 30, color: UIColor.gray, title: "")
//        let thirdItem: RKPieChartItem = RKPieChartItem(ratio: 20, color: UIColor.yellow, title: "")
//
//        let chart = RKPieChartView(items: [firstItem,secondItem,thirdItem], centerTitle: NSAttributedString.init(string: ""))
//        chart.circleColor = .clear
//        chart.translatesAutoresizingMaskIntoConstraints = false
//        chart.arcWidth = 10
//        chart.isIntensityActivated = false
//        chart.style = .butt
//        chart.isTitleViewHidden = true
//        chart.isAnimationActivated = true
//        self.chartViewContainer.addSubview(chart)
//
//        self.chartViewContainer.addConstraints([
//            NSLayoutConstraint(item: chart, attribute: .leading, relatedBy: .equal, toItem: chartViewContainer, attribute: .leading, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: chart, attribute: .trailing, relatedBy: .equal, toItem: chartViewContainer, attribute: .trailing, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: chart, attribute: .top, relatedBy: .equal, toItem: chartViewContainer, attribute: .top, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: chart, attribute: .bottom, relatedBy: .equal, toItem: chartViewContainer, attribute: .bottom, multiplier: 1.0, constant: 0),
//            ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
