//
//  PracticeMainViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/28/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit


struct PracticeWholeModel {
    var practiceType : PracticeType?
    var knowledgeArea : KnowledgeArea?
    var processGroup : ProcessGroup?
    var level : Int?
}

enum PracticeType {
    case knowledgeArea
    case processGroup
}

enum KnowledgeArea : String{
    case ProjectIntegrationManagement = "Project Integration Management"
    case ProjectScopeManagement = "Project Scope Management"
    case ProjectScheduleManagement = "Project Schedule Management"
    case ProjectCostManagement = "Project Cost Management"
    case ProjectQualityManagement = "Project Quality Management"
    
    case ProjectResourceManagement = "Project Resource Management"
    case ProjectCommunicationsManagement = "Project Communications Management"
    case ProjectRiskManagement = "Project Risk Management"
    case ProjectProcurementManagement = "Project Procurement Management"
    case ProjectStakeholderManagement = "Project Stakeholder Management"
}

enum ProcessGroup : String {
    case InitiatingProcessGroup = "Initiating Process Group"
    case PlanningProcessGroup = "Planning Process Group"
    case ExecutingProcessGroup = "Executing Process Group"
    case MonitoringAndControllingProcessGroup = "Monitoring and Controlling Process Group"
    case ClosingProcessGroup = "Closing Process Group"
}


class PracticeMainViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = 0
    var practiceWholeModel = PracticeWholeModel()
    
    var allcount = PracticesDBManager.sharedInstance.getDataFromDB().count
    
    @IBOutlet weak var knowledgAreaView: UIView!
    @IBOutlet weak var processGroupView: UIView!
    
    @IBOutlet weak var knowledgeAreaLabel: UILabel!
    @IBOutlet weak var processGroupLabel: UILabel!
    
    var knowledgeAreasArray = [KnowledgeArea.ProjectIntegrationManagement.rawValue,KnowledgeArea.ProjectScopeManagement.rawValue,KnowledgeArea.ProjectScheduleManagement.rawValue,KnowledgeArea.ProjectCostManagement.rawValue,KnowledgeArea.ProjectQualityManagement.rawValue,KnowledgeArea.ProjectResourceManagement.rawValue,KnowledgeArea.ProjectCommunicationsManagement.rawValue,KnowledgeArea.ProjectRiskManagement.rawValue,KnowledgeArea.ProjectProcurementManagement.rawValue,KnowledgeArea.ProjectStakeholderManagement.rawValue]
    
    var processGroupsArray = [ProcessGroup.InitiatingProcessGroup.rawValue,ProcessGroup.PlanningProcessGroup.rawValue,ProcessGroup.ExecutingProcessGroup.rawValue,ProcessGroup.MonitoringAndControllingProcessGroup.rawValue,ProcessGroup.ClosingProcessGroup
        .rawValue]
    
    var presenter: PracticeMainPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.showKnowledgeArea(UIButton.init())
        self.presenter = PracticeMainPresenter()
//        (self.presenter as! PracticeMainPresenter).setLevelsUserDefaults()
        
        tableView.register(UINib.init(nibName: "PracticeMainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PracticeMainTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction func showKnowledgeArea(_ sender: Any) {
        self.knowledgAreaView.backgroundColor = UIColor.PMPNewBlue
        self.processGroupView.backgroundColor = UIColor.white
        
        self.knowledgeAreaLabel.textColor = UIColor.white
        self.processGroupLabel.textColor = UIColor.darkGray
        selectedIndex = 0
        
        practiceWholeModel.practiceType = .knowledgeArea
        
        self.tableView.reloadData()
    }
    
    @IBAction func showProcessGroup(_ sender: Any) {
        self.processGroupView.backgroundColor = UIColor.PMPNewBlue
        self.knowledgAreaView.backgroundColor = UIColor.white
        
        self.processGroupLabel.textColor = UIColor.white
        self.knowledgeAreaLabel.textColor = UIColor.darkGray
        selectedIndex = 1
        
        practiceWholeModel.practiceType = .processGroup
        
        self.tableView.reloadData()
    }
}

extension PracticeMainViewController: PracticeMainView {
    // TODO: implement view output methods
}

extension PracticeMainViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Practices"
    }
}

extension PracticeMainViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 0{
            return 10
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"PracticeMainTableViewCell") as! PracticeMainTableViewCell
        if selectedIndex == 0{
            cell.titleLabel.text = self.knowledgeAreasArray[indexPath.row]
            let knowledgeAreaCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "knowledgeArea = [c]'\(self.knowledgeAreasArray[indexPath.row])'").count)
            let correctCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "correctAnswer = userAnswer AND knowledgeArea = [c]'\(self.knowledgeAreasArray[indexPath.row])'").count)
            
            cell.percentageLabel.text = "\(String(format: "%.0f", Float(correctCount / knowledgeAreaCount)*100))%"
            cell.drawChart(progress: Float(correctCount / knowledgeAreaCount))
        }else{
            cell.titleLabel.text = self.processGroupsArray[indexPath.row]
            let knowledgeAreaCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "processGroup = [c]'\(self.processGroupsArray[indexPath.row])'").count)
            let correctCount = Float( PracticesDBManager.sharedInstance.filterData(filterSyntax: "correctAnswer = userAnswer AND processGroup = [c]'\(self.processGroupsArray[indexPath.row])'").count)
            
            cell.percentageLabel.text = "\(String(format: "%.0f", Float(correctCount / knowledgeAreaCount)*100))%"
            cell.drawChart(progress: Float(correctCount / knowledgeAreaCount))
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension PracticeMainViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if practiceWholeModel.practiceType == .knowledgeArea{
            if indexPath.row == 0{
                practiceWholeModel.knowledgeArea = .ProjectIntegrationManagement
            }else if indexPath.row == 1{
                practiceWholeModel.knowledgeArea = .ProjectScopeManagement
            }else if indexPath.row == 2{
                practiceWholeModel.knowledgeArea = .ProjectScheduleManagement
            }else if indexPath.row == 3{
                practiceWholeModel.knowledgeArea = .ProjectCostManagement
            }else if indexPath.row == 4{
                practiceWholeModel.knowledgeArea = .ProjectQualityManagement
            }else if indexPath.row == 5{
                practiceWholeModel.knowledgeArea = .ProjectResourceManagement
            }else if indexPath.row == 6{
                practiceWholeModel.knowledgeArea = .ProjectCommunicationsManagement
            }else if indexPath.row == 7{
                practiceWholeModel.knowledgeArea = . ProjectRiskManagement
            }else if indexPath.row == 8{
                practiceWholeModel.knowledgeArea = .ProjectProcurementManagement
            }else if indexPath.row == 9{
                practiceWholeModel.knowledgeArea = .ProjectStakeholderManagement
            }
        }else{
            if indexPath.row == 0{
                practiceWholeModel.processGroup = .InitiatingProcessGroup
            }else if indexPath.row == 1{
                practiceWholeModel.processGroup = .PlanningProcessGroup
            }else if indexPath.row == 2{
                practiceWholeModel.processGroup = .ExecutingProcessGroup
            }else if indexPath.row == 3{
                practiceWholeModel.processGroup = .MonitoringAndControllingProcessGroup
            }else if indexPath.row == 4{
                practiceWholeModel.processGroup = .ClosingProcessGroup
            }
        }
        let levelsVC = PracticeLevelsRouter.setupModule()
        levelsVC.practiceWholeModel = self.practiceWholeModel
        self.navigationController?.pushViewController(levelsVC, animated: true)
    }
}
