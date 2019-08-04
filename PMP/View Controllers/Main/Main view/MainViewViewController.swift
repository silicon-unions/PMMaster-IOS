//
//  MainViewViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import RKPieChart
import AnimatedCollectionViewLayout
import RealmSwift

class DateQuestionsTransactions : Object{
    @objc dynamic var date : String?
    @objc dynamic var correctCount : Int = 0
    @objc dynamic var wrongCount : Int = 0
}

class MainViewViewController: BaseViewController, StoryboardLoadable {
    // MARK: Properties

    var presenter: MainViewPresentation?
//    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var daysRemainingLabel: UILabel!
    
    @IBOutlet weak var examsChartContainer: UIView!
    @IBOutlet weak var dailyHistoryChartContainer: UIView!
    @IBOutlet weak var avgTimeChartContainer : UIView!
    @IBOutlet weak var practicesChartContainer: UIView!
    
    @IBOutlet weak var practicesSubtitleLabel: UILabel!
    @IBOutlet weak var examsSubtitleLabel: UILabel!
    @IBOutlet weak var daysLeftContainerView: UIView!
    @IBOutlet weak var daysLeftContainerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var quickQuestionsButton: UIButton!
    @IBOutlet weak var upgradeView: UIView!
    @IBOutlet weak var upgradeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    var isChartsLoaded = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
//    @IBOutlet weak var chartViewContainer: UIView!
//    @IBOutlet weak var pageControl: UIPageControl!

//    @IBOutlet weak var collectionView: UICollectionView!
    var animator = (RotateInOutAttributesAnimator(), true, 1, 1)
    var direction: UICollectionViewScrollDirection = .horizontal
    
    let exams = ExamsDBManager.sharedInstance.getExamsFromDB()
    
    var practicesNumber = 0
    
    var knowledgeAreasArray = [KnowledgeArea.ProjectIntegrationManagement.rawValue,KnowledgeArea.ProjectScopeManagement.rawValue,KnowledgeArea.ProjectScheduleManagement.rawValue,KnowledgeArea.ProjectCostManagement.rawValue,KnowledgeArea.ProjectQualityManagement.rawValue,KnowledgeArea.ProjectResourceManagement.rawValue,KnowledgeArea.ProjectCommunicationsManagement.rawValue,KnowledgeArea.ProjectRiskManagement.rawValue,KnowledgeArea.ProjectProcurementManagement.rawValue,KnowledgeArea.ProjectStakeholderManagement.rawValue]
    
    var processGroupsArray = [ProcessGroup.InitiatingProcessGroup.rawValue,ProcessGroup.PlanningProcessGroup.rawValue,ProcessGroup.ExecutingProcessGroup.rawValue,ProcessGroup.MonitoringAndControllingProcessGroup.rawValue,ProcessGroup.ClosingProcessGroup
        .rawValue]

    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        if isChartsLoaded{
            self.drawCharts()
        }
        if (self.presenter as! MainViewPresenter).canUpdateUserLevelsAgain == true && appDelegate.isFreeVersion! == false{
            (self.presenter as! MainViewPresenter).callUpdateUserLevels()
        }
        if let examDate = UserDefaults.standard.value(forKey: (appDelegate.examDateKey)){
            daysLeftContainerView.subviews.forEach({ $0.isHidden = false })
            daysLeftContainerViewHeightConstraint.constant = 66.5
            
            let calendar = NSCalendar.current
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: examDate as! Date)
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            daysRemainingLabel.text = "\(components.day!) Days"
        }else{
            daysLeftContainerView.subviews.forEach({ $0.isHidden = true })
            daysLeftContainerViewHeightConstraint.constant = 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainViewPresenter()
        (self.presenter as! MainViewPresenter).view = self
        (self.presenter as! MainViewPresenter).initInteractor()
        if appDelegate.isFreeVersion!{
            (self.presenter as! MainViewPresenter).setLevelsAllToOne()
        }
        if !appDelegate.isFreeVersion! && appDelegate.newlyLoggedIn == true{
            (self.presenter as! MainViewPresenter).callUserLevels()
        }else{
            (self.presenter as! MainViewPresenter).callAllPracticeQuestions()
        }
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "PracticeMainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PracticeMainTableViewCell")
        
        
        // Replace the hour (time) of both dates with 00:00
        if appDelegate.isFreeVersion == false{
            self.upgradeView.subviews.forEach({ $0.removeFromSuperview()})
            self.upgradeViewHeightConstraint.constant = 0
        }
        
        
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = animator.0
        layout.scrollDirection = direction
//        collectionView.collectionViewLayout = layout
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        
//        collectionView.isPagingEnabled = true
        
//        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
//            layout.scrollDirection = direction
//            layout.animator = animator.0
//        }
        
//        collectionView.register(UINib.init(nibName: "ChartCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ChartCollectionViewCell")
        
//        shadowView.layer.cornerRadius = 15.0
//        shadowView.layer.borderWidth = 0.5
//        shadowView.layer.borderColor = UIColor.lightGray.cgColor
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOpacity = 0.5
//        shadowView.layer.shadowRadius = 3.0
//        shadowView.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
//
//
//        let firstItem: RKPieChartItem = RKPieChartItem(ratio: 50, color: UIColor.orange, title: "Correct answers: 2")
//        let secondItem: RKPieChartItem = RKPieChartItem(ratio: 30, color: UIColor.gray, title: "Wrong answers: 6")
//        let thirdItem: RKPieChartItem = RKPieChartItem(ratio: 20, color: UIColor.yellow, title: "total questions: 8")
//
//        let chartView = RKPieChartView(items: [firstItem, secondItem, thirdItem], centerTitle: "Exam\n Statistics")
//        chartView.circleColor = .clear
//        chartView.translatesAutoresizingMaskIntoConstraints = false
//        chartView.arcWidth = 20
//        chartView.isIntensityActivated = false
//        chartView.style = .butt
//        chartView.isTitleViewHidden = false
//        chartView.isAnimationActivated = true
//        self.chartViewContainer.addSubview(chartView)
//
//        self.chartViewContainer.addConstraints([
//            NSLayoutConstraint(item: chartView, attribute: .leading, relatedBy: .equal, toItem: chartViewContainer, attribute: .leading, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: chartView, attribute: .trailing, relatedBy: .equal, toItem: chartViewContainer, attribute: .trailing, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: chartView, attribute: .top, relatedBy: .equal, toItem: chartViewContainer, attribute: .top, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: chartView, attribute: .bottom, relatedBy: .equal, toItem: chartViewContainer, attribute: .bottom, multiplier: 1.0, constant: 0),
//            ])
        
        
        
//        chartView.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        chartView.heightAnchor.constraint(equalToConstant: 250).isActive = true
//        chartView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        chartView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
    func setupViewAfterLoadingData() {
        self.drawCharts()
        isChartsLoaded = true
        self.practicesNumber = 15
        self.tableView.reloadData()
    }
    @IBAction func upgrade(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: "http://itunes.apple.com/us/app/pmp-master/id1436983404?ls=1&mt=8")!, options: [:], completionHandler: nil)
    }
    
    func drawCharts(){
        
        examsChartContainer.subviews.forEach({ $0.removeFromSuperview()})
        dailyHistoryChartContainer.subviews.forEach({ $0.removeFromSuperview() })
        avgTimeChartContainer.subviews.forEach({ $0.removeFromSuperview() })
        practicesChartContainer.subviews.forEach({ $0.removeFromSuperview() })
        
        let allCount : Int = Int(PracticesDBManager.sharedInstance.getDataFromDB().count)
        let correctCount : Int = Int(PracticesDBManager.sharedInstance.filterData(filterSyntax: "correctAnswer = userAnswer").count)
        
        var percentage : Double = 0.0
        if correctCount == 0 && allCount == 0{
            percentage = 0.0
        }else{
            percentage = Double(Double(correctCount)/Double(allCount) * 100)
        }
//        let percentageString = "\(String(format: "%.1f", percentage))%"
        
        let title = "\(correctCount)" + "\nCorrect"
        let attributes = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)]
        let attTitle = NSMutableAttributedString(string: title)
        attTitle.addAttributes(attributes, range: NSRange.init(location: 0, length: "\(correctCount)".count))
        attTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 8), range: NSRange.init(location: "\(correctCount)".count, length: "\nCorrect".count))
        
        let firstItem: RKPieChartItem = RKPieChartItem(ratio: uint(percentage), color: UIColor.orange, title: "Correct answers: \(correctCount)")
        
        let chart = RKPieChartView(items: [firstItem], centerTitle: attTitle)
        chart.circleColor = .lightGray
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.arcWidth = 8
        chart.isIntensityActivated = false
        chart.style = .butt
        chart.isTitleViewHidden = true
        chart.isAnimationActivated = true
        self.practicesChartContainer.addSubview(chart)
        
        self.practicesChartContainer.addConstraints([
            NSLayoutConstraint(item: chart, attribute: .leading, relatedBy: .equal, toItem: practicesChartContainer, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .trailing, relatedBy: .equal, toItem: practicesChartContainer, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .top, relatedBy: .equal, toItem: practicesChartContainer, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .bottom, relatedBy: .equal, toItem: practicesChartContainer, attribute: .bottom, multiplier: 1.0, constant: 0),
            ])
        
        
        
        var allExamsQuestionsCount = 0
        var allExamscorrectQuestionsCount = 0
        
        for exam in self.exams{
            allExamsQuestionsCount += exam.examQuestions.count
            for question in exam.examQuestions{
                if question.correctAnswer == question.userAnswer{
                    allExamscorrectQuestionsCount += 1
                }
            }
        }
        
        var examsPercentage : Double = 0
        
        if allExamsQuestionsCount != 0{
            examsPercentage = Double(Double(allExamscorrectQuestionsCount)/Double(allExamsQuestionsCount) * 100)
        }
        //        let percentageString = "\(String(format: "%.1f", percentage))%"
        
        let examTitle = "\(allExamscorrectQuestionsCount)" + "\nCorrect"
        let examAttributes = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)]
        let examAttTitle = NSMutableAttributedString(string: examTitle)
        examAttTitle.addAttributes(examAttributes, range: NSRange.init(location: 0, length: "\(allExamscorrectQuestionsCount)".count))
        examAttTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 9), range: NSRange.init(location: "\(allExamscorrectQuestionsCount)".count, length: "\nCorrect".count))
        
        let examFirstItem: RKPieChartItem = RKPieChartItem(ratio: uint(examsPercentage), color: UIColor.orange, title: "Correct answers: \(allExamscorrectQuestionsCount)")
        
        let examChart = RKPieChartView(items: [examFirstItem], centerTitle: examAttTitle)
        examChart.circleColor = .lightGray
        examChart.translatesAutoresizingMaskIntoConstraints = false
        examChart.arcWidth = 10
        examChart.isIntensityActivated = false
        examChart.style = .butt
        examChart.isTitleViewHidden = true
        examChart.isAnimationActivated = true
        self.examsChartContainer.addSubview(examChart)
        
        self.examsChartContainer.addConstraints([
            NSLayoutConstraint(item: examChart, attribute: .leading, relatedBy: .equal, toItem: examsChartContainer, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: examChart, attribute: .trailing, relatedBy: .equal, toItem: examsChartContainer, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: examChart, attribute: .top, relatedBy: .equal, toItem: examsChartContainer, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: examChart, attribute: .bottom, relatedBy: .equal, toItem: examsChartContainer, attribute: .bottom, multiplier: 1.0, constant: 0),
            ])
        
        practicesSubtitleLabel.text = "Goal: \(allCount) questions"
        examsSubtitleLabel.text = "Goal: 70%"
        
        let defaults:UserDefaults = UserDefaults.standard
        var studyTimeTitle = ""
        var minutsSubtitle = ""
        if let mins = defaults.string(forKey: "minutes"){
            minutsSubtitle = mins
        }else{
            minutsSubtitle = "0"
        }
        
        studyTimeTitle = minutsSubtitle + "\nMinutes"
        
        let studyTimeAttributes = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)]
        let studyTimeAttTitle = NSMutableAttributedString(string: studyTimeTitle)
        studyTimeAttTitle.addAttributes(studyTimeAttributes, range: NSRange.init(location: 0, length: minutsSubtitle.count))
        studyTimeAttTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 9), range: NSRange.init(location: "\(minutsSubtitle)".count, length: "\nMinutes".count))
        let studyTimeItem: RKPieChartItem = RKPieChartItem(ratio: uint(Double(minutsSubtitle)!/(24*60) * 100), color: UIColor.orange, title: "")
        let avgTimeChart = RKPieChartView(items: [studyTimeItem], centerTitle: studyTimeAttTitle)
        avgTimeChart.circleColor = .lightGray
        avgTimeChart.translatesAutoresizingMaskIntoConstraints = false
        avgTimeChart.arcWidth = 10
        avgTimeChart.isIntensityActivated = false
        avgTimeChart.style = .butt
        avgTimeChart.isTitleViewHidden = true
        avgTimeChart.isAnimationActivated = true
        self.avgTimeChartContainer.addSubview(avgTimeChart)
        
        self.avgTimeChartContainer.addConstraints([
            NSLayoutConstraint(item: avgTimeChart, attribute: .leading, relatedBy: .equal, toItem: avgTimeChartContainer, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: avgTimeChart, attribute: .trailing, relatedBy: .equal, toItem: avgTimeChartContainer, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: avgTimeChart, attribute: .top, relatedBy: .equal, toItem: avgTimeChartContainer, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: avgTimeChart, attribute: .bottom, relatedBy: .equal, toItem: avgTimeChartContainer, attribute: .bottom, multiplier: 1.0, constant: 0),
            ])
        
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        
        var todayTransactionsCount = 0
        if let todayTransactions = DateDBManager.sharedInstance.getTransactionsWithdate(date: dateString){
            todayTransactionsCount = todayTransactions.correctCount + todayTransactions.wrongCount
        }
        
        let dailyTitle = "Today" + "\nExams"
        let dailyAttributes = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)]
        let dailyAttTitle = NSMutableAttributedString(string: dailyTitle)
        dailyAttTitle.addAttributes(dailyAttributes, range: NSRange.init(location: 0, length: dailyTitle.count))
        
        let dailyFirstItem: RKPieChartItem = RKPieChartItem(ratio: (uint((Double(todayTransactionsCount)/100)*100)), color: UIColor.orange, title: "")
        
        let dailyChart = RKPieChartView(items: [dailyFirstItem], centerTitle: dailyAttTitle)
        dailyChart.circleColor = .lightGray
        dailyChart.translatesAutoresizingMaskIntoConstraints = false
        dailyChart.arcWidth = 8
        dailyChart.isIntensityActivated = false
        dailyChart.style = .butt
        dailyChart.isTitleViewHidden = true
        dailyChart.isAnimationActivated = true
        self.dailyHistoryChartContainer.addSubview(dailyChart)
        
        self.dailyHistoryChartContainer.addConstraints([
            NSLayoutConstraint(item: dailyChart, attribute: .leading, relatedBy: .equal, toItem: dailyHistoryChartContainer, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: dailyChart, attribute: .trailing, relatedBy: .equal, toItem: dailyHistoryChartContainer, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: dailyChart, attribute: .top, relatedBy: .equal, toItem: dailyHistoryChartContainer, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: dailyChart, attribute: .bottom, relatedBy: .equal, toItem: dailyHistoryChartContainer, attribute: .bottom, multiplier: 1.0, constant: 0),
            ])
    }
    
    @IBAction func showMainList(_ sender: Any) {
//        let mainListVC = MainListRouter.setupModule()
//        mainListVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        self.navigationController?.present(mainListVC, animated: true, completion: nil)
        
        MainViewRouter.showMainList(navigation: self.navigationController!)
    }
    
    @IBAction func showProfile(_ sender: Any) {
        self.navigationController?.pushViewController(ProfileRouter.setupModule(), animated: true)
    }
    
}

extension MainViewViewController: MainViewView {
    // TODO: implement view output methods
}

//extension MainViewViewController: UICollectionViewDataSource{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCollectionViewCell", for: indexPath)
//        return c
//    }
//}

//extension MainViewViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        guard let animator = animator else { return view.bounds.size }
//        return CGSize(width: self.collectionView.bounds.width / CGFloat(animator.2) , height: self.collectionView.bounds.height / CGFloat(animator.3))
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
extension MainViewViewController: UICollectionViewDelegate{
    
}



extension MainViewViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return practicesNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"PracticeMainTableViewCell") as! PracticeMainTableViewCell
        cell.isUserInteractionEnabled = false
        
        if indexPath.row < 10{
            let knowledgeAreaCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "knowledgeArea = [c]'\(self.knowledgeAreasArray[indexPath.row])'").count)
            let correctCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "correctAnswer = userAnswer AND knowledgeArea = [c]'\(self.knowledgeAreasArray[indexPath.row])'").count)
            cell.titleLabel.text = self.knowledgeAreasArray[indexPath.row]
            cell.percentageLabel.text = "\(String(format: "%.0f", Float(correctCount / knowledgeAreaCount)))%"
            if knowledgeAreaCount == 0{
                cell.drawChart(progress: Float(0.0))
            }else{
                cell.drawChart(progress: Float(correctCount / knowledgeAreaCount))
            }
        }else{
            let processGroupsCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "processGroup = [c]'\(self.processGroupsArray[indexPath.row - 10])'").count)
            let processGroupsCorrectCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "correctAnswer = userAnswer AND processGroup = [c]'\(self.knowledgeAreasArray[indexPath.row - 10])'").count)
            
            cell.titleLabel.text = self.processGroupsArray[indexPath.row - 10]
            cell.percentageLabel.text = "\(String(format: "%.0f", Float(processGroupsCorrectCount / processGroupsCount)))%"
            if processGroupsCount == 0 {
                cell.drawChart(progress: Float(0.0))
            }else{
                cell.drawChart(progress: Float(processGroupsCorrectCount / processGroupsCount))
            }
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension MainViewViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

