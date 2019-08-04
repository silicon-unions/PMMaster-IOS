//
//  PracticeLevelsPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/28/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class PracticeLevelsPresenter {

    // MARK: Properties

    var view: PracticeLevelsView?
    var router: PracticeLevelsWireframe?
    var interactor: PracticeLevelsUseCase?
    
    
    
    func currentLevel() -> Int{
        let defaults:UserDefaults = UserDefaults.standard
        let practiceLevelsViewController = self.view as! PracticeLevelsViewController
        if practiceLevelsViewController.practiceWholeModel?.practiceType == .knowledgeArea{
            return(Int(defaults.string(forKey: (practiceLevelsViewController.practiceWholeModel?.knowledgeArea!.rawValue)!)!))!
        }else{
            return(Int(defaults.string(forKey: (practiceLevelsViewController.practiceWholeModel?.processGroup!.rawValue)!)!))!
        }
    }
    func callUpdateUserLevels(){
        let practiceLevelsViewController = self.view as! PracticeLevelsViewController
        practiceLevelsViewController.showSpinner()
        
        var params = Dictionary<String,Any>()
        params["levels"] = self.userLevelsFromDefaults().toJSON()
        
        let mainInteractor = MainViewInteractor()
        (mainInteractor as! MainViewInteractor).callUpdateUserLevels(params: params) { (model, error) in
            
            practiceLevelsViewController.hideSpinner()
            
            if error != nil {
                (self.view as! MainViewViewController).showDefaultAlert(message: (error?.localizedDescription)!, popView: true)
                return
            }
            guard let success = (model as! AppBaseModel).success else{
                return
            }
            
            if success{
            }else{
                (self.view as! MainViewViewController).showDefaultAlert(message: (model as! ExamQuestionDataModel).reason!,popView: false)
                practiceLevelsViewController.hideSpinner()
            }
        }
    }
    
    func userLevelsFromDefaults() -> PracticeLevelsDataModel {
        let levels = PracticeLevelsDataModel(json: [String : Any].init())
        let defaults:UserDefaults = UserDefaults.standard
        
        levels?.levelForInitiatingProcessGroup = defaults.value(forKey: ProcessGroup.InitiatingProcessGroup.rawValue) as? String
        levels?.levelForPlanningProcessGroup = defaults.value(forKey: ProcessGroup.PlanningProcessGroup.rawValue) as? String
        levels?.levelForExecutingProcessGroup = defaults.value(forKey: ProcessGroup.ExecutingProcessGroup.rawValue) as? String
        levels?.levelForMonitoringControllingProcessGroup = defaults.value(forKey: ProcessGroup.MonitoringAndControllingProcessGroup.rawValue) as? String
        levels?.levelForClosingProcessGroup = defaults.value(forKey: ProcessGroup.ClosingProcessGroup.rawValue) as? String
        
        
        levels?.levelForProjectIntegrationManagement =  defaults.value(forKey: KnowledgeArea.ProjectIntegrationManagement.rawValue) as? String
        levels?.levelForProjectScopeManagement = defaults.value(forKey: KnowledgeArea.ProjectScopeManagement.rawValue) as? String
        levels?.levelForProjectScheduleManagement = defaults.value(forKey: KnowledgeArea.ProjectScheduleManagement.rawValue) as? String
        levels?.levelForProjectCostManagement = defaults.value(forKey: KnowledgeArea.ProjectCostManagement.rawValue) as? String
        levels?.levelForProjectQualityManagement = defaults.value(forKey: KnowledgeArea.ProjectQualityManagement.rawValue) as? String
        levels?.levelForProjectResourceManagement = defaults.value(forKey: KnowledgeArea.ProjectResourceManagement.rawValue) as? String
        levels?.levelForProjectCommunicationsManagement = defaults.value(forKey: KnowledgeArea.ProjectCommunicationsManagement.rawValue) as? String
        levels?.levelForProjectRiskManagement = defaults.value(forKey: KnowledgeArea.ProjectRiskManagement.rawValue) as? String
        levels?.levelForProjectProcurementManagement = defaults.value(forKey: KnowledgeArea.ProjectProcurementManagement.rawValue) as? String
        levels?.levelForProjectStakeholderManagement = defaults.value(forKey: KnowledgeArea.ProjectStakeholderManagement.rawValue) as? String
        
        return levels!
        
    }
}

extension PracticeLevelsPresenter: PracticeLevelsPresentation {
    // TODO: implement presentation methods
}

extension PracticeLevelsPresenter: PracticeLevelsInteractorOutput {
    // TODO: implement interactor output methods
}
