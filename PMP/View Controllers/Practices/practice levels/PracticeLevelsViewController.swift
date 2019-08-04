//
//  PracticeLevelsViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/28/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit
import RKPieChart

extension Notification.Name {
    static let showCongratulationsNotification = Notification.Name("showCongratulationsNotification")
}

class PracticeLevelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lockerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func drawChart(progress : UInt) {
        
        let firstItem: RKPieChartItem = RKPieChartItem(ratio: uint(progress), color: UIColor.orange, title: "")
        let secondItem: RKPieChartItem = RKPieChartItem(ratio: uint(100 - progress), color: UIColor.gray, title: "")

        let chart = RKPieChartView(items: [firstItem,secondItem], centerTitle: NSAttributedString.init(string: "\(progress)%", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 9)]))
        chart.circleColor = .clear
        if progress == 100{
            chart.circleColor = .orange
        }
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.arcWidth = 5
        chart.isIntensityActivated = false
        chart.style = .butt
        chart.isTitleViewHidden = true
        chart.isAnimationActivated = true
        self.containerView.addSubview(chart)

        self.containerView.addConstraints([
            NSLayoutConstraint(item: chart, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: chart, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0),
            ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class PracticeLevelsViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var practiceWholeModel : PracticeWholeModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var presenter: PracticeLevelsPresentation?

    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        if presenter != nil{
            (self.presenter as! PracticeLevelsPresenter).callUpdateUserLevels()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.presenter = PracticeLevelsPresenter()
        (self.presenter as! PracticeLevelsPresenter).view = self
        if practiceWholeModel?.practiceType == .knowledgeArea{
            self.titleLabel.text = practiceWholeModel?.knowledgeArea?.rawValue
        }else{
            self.titleLabel.text = practiceWholeModel?.processGroup?.rawValue
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showNotification), name: .showCongratulationsNotification, object: nil)
//        tableView.register(UINib.init(nibName: "PracticeLevelTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PracticeLevelTableViewCell")
    }
    
    @objc func showNotification(){
        self.navigationController?.popViewController(animated: false)
        self.showCongratulation()
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
    
    func percentage(level : Int) -> Float {
        if practiceWholeModel?.practiceType == .knowledgeArea{
            let correctQuestions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(level)' AND knowledgeArea = [c]'\((practiceWholeModel!.knowledgeArea?.rawValue)!)' AND correctAnswer == userAnswer")
            
            let allQuestions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(level)' AND knowledgeArea = [c]'\((practiceWholeModel!.knowledgeArea?.rawValue)!)'")
            
            if allQuestions.count == 0{
                return 0
            }
            
            return Float(correctQuestions.count) / Float(allQuestions.count) * 100
        }else{
            let correctQuestions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(level)' AND processGroup = [c]'\((practiceWholeModel!.processGroup?.rawValue)!)' AND correctAnswer == userAnswer")
            
            let allQuestions = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '\(level)' AND processGroup = [c]'\((practiceWholeModel!.processGroup?.rawValue)!)'")
            
            if allQuestions.count == 0{
                return 0
            }
            
            return Float(correctQuestions.count) / Float(allQuestions.count) * 100
        }
    }
}

extension PracticeLevelsViewController: PracticeLevelsView {
    // TODO: implement view output methods
}

extension PracticeLevelsViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Practices"
    }
}

extension PracticeLevelsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"PracticeLevelTableViewCell") as! PracticeLevelTableViewCell
        
        
        if appDelegate.isFreeVersion!{
            if indexPath.row != 0 {
                cell.subTitleLabel.text = "Upgrade to have access to this level"
                cell.containerView.isHidden = true
                cell.lockerImageView.isHidden = false
            }else{
                cell.subTitleLabel.text = "This is your current level"
                cell.containerView.isHidden = false
                cell.lockerImageView.isHidden = true
                cell.containerView.subviews.forEach({ $0.removeFromSuperview()})
                cell.drawChart(progress: UInt(self.percentage(level: indexPath.row+1)))
            }
        }else{
            if indexPath.row+1 <= (self.presenter as! PracticeLevelsPresenter).currentLevel(){
                cell.titleLabel.alpha = 1
                if indexPath.row+1 < (self.presenter as! PracticeLevelsPresenter).currentLevel(){
                    cell.subTitleLabel.text = "This level is finished"
                }else if indexPath.row+1 == (self.presenter as! PracticeLevelsPresenter).currentLevel(){
                    cell.subTitleLabel.text = "This is your current level"
                }
                cell.subTitleLabel.text = "This is your current level"
                cell.lockerImageView.isHidden = true
                cell.containerView.isHidden = false
                cell.containerView.subviews.forEach({ $0.removeFromSuperview()})
                cell.drawChart(progress: UInt(self.percentage(level: indexPath.row+1)))
            }else{
                cell.subTitleLabel.text = "Complete previous levels"
                cell.lockerImageView.isHidden = false
                cell.containerView.isHidden = true
            }
            
        }
        cell.titleLabel.text = "Level \(indexPath.row+1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension PracticeLevelsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.practiceWholeModel?.level = indexPath.row + 1
        if appDelegate.isFreeVersion!{
            if indexPath.row == 0{
                let practiceQuestionVC = PracticeQuestionRouter.setupModule()
                practiceQuestionVC.practiceWholeModel = self.practiceWholeModel
                self.navigationController?.pushViewController(practiceQuestionVC, animated: true)
            }else{
                let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
                alertVC.delegate = self
                alertVC.bodyText = "Upgrade to have access to full version"
                alertVC.okButtonTitle = "UPGRADE"
                alertVC.dialogType = .upgrade
                alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.navigationController?.present(alertVC, animated: true, completion: nil)
            }
        }else{
            if indexPath.row+1 <= (self.presenter as! PracticeLevelsPresenter).currentLevel(){
                let practiceQuestionVC = PracticeQuestionRouter.setupModule()
                practiceQuestionVC.practiceWholeModel = self.practiceWholeModel
                self.navigationController?.pushViewController(practiceQuestionVC, animated: true)
            }else{
                let alertVC = UIStoryboard.init(name: "Exam", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
                alertVC.delegate = self
                alertVC.bodyText = "You must finish previous opened levels"
                alertVC.okButtonTitle = "OK"
                alertVC.isOnlyOneButton = true
                alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.navigationController?.present(alertVC, animated: true, completion: nil)
            }
        }
        if practiceWholeModel?.practiceType == .knowledgeArea{
            if indexPath.row == 0{
                
            }else if indexPath.row == 1{
                
            }
        }else{
            if indexPath.row == 0{
             
            }else if indexPath.row == 1{
             
            }
        }
    }
}

extension PracticeLevelsViewController : AlertViewControllerDelegate{
    func okButtonPressed(type:DialogType){
        if type == .upgrade{
            UIApplication.shared.open(URL.init(string: "http://itunes.apple.com/us/app/pmp-master/id1436983404?ls=1&mt=8")!, options: [:], completionHandler: nil)
        }
    }
    func cancelButtonPressed(type:DialogType){
        
    }
}
