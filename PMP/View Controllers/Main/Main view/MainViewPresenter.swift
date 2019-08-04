//
//  MainViewPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/22/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class MainViewPresenter {

    // MARK: Properties

    var view: MainViewView?
    var router: MainViewWireframe?
    var interactor: MainViewUseCase?
    var practiceMainViewModel = PracticeMainViewModel()
    var i = 1
    var allPracticeQuestions = [PracticeQuestion]()
    var canUpdateUserLevelsAgain = false
    
    func initInteractor() {
        interactor = MainViewInteractor()
    }
    
    func callUserLevels(){
        let mainViewViewController = self.view as! MainViewViewController
        mainViewViewController.showSpinner()
        
        (interactor as! MainViewInteractor).callUserLevels(params: [:]) { (model, error) in
            
            mainViewViewController.hideSpinner()
            
            if error != nil {
                (self.view as! MainViewViewController).showDefaultAlert(message: (error?.localizedDescription)!, popView: true)
                return
            }
            guard let success = (model as! PracticeLevelsDataModel).success else{
                return
            }
            
            if success{
                self.setLevelsUserDefaults(model: (model as! PracticeLevelsDataModel))
                self.callUpdateUserLevels()
            }else{
                (self.view as! ProfileViewController).showDefaultAlert(message: (model as! ExamQuestionDataModel).reason!,popView: false)
                
            }
        }
    }
    
    func callUpdateUserLevels(){
        let mainViewViewController = self.view as! MainViewViewController
        mainViewViewController.showSpinner()
        
        var params = Dictionary<String,Any>()
        params["levels"] = self.userLevelsFromDefaults().toJSON()
        
        (interactor as! MainViewInteractor).callUpdateUserLevels(params: params) { (model, error) in
            
            mainViewViewController.hideSpinner()
            self.callAllPracticeQuestions()
            
            if error != nil {
                (self.view as! MainViewViewController).showDefaultAlert(message: (error?.localizedDescription)!, popView: true)
                return
            }
            guard let success = (model as! AppBaseModel).success else{
                return
            }
            
            if success{
                self.canUpdateUserLevelsAgain = true
            }else{
                (self.view as! MainViewViewController).showDefaultAlert(message: (model as! ExamQuestionDataModel).reason!,popView: false)
                mainViewViewController.hideSpinner()
            }
        }
    }
    
    
    
    func callAllPracticeQuestions(){
        let mainViewViewController = self.view as! MainViewViewController
//        var list = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '2' AND knowledgeArea = [c]'\(KnowledgeArea.ProjectScopeManagement.rawValue)'")
//        var list = PracticesDBManager.sharedInstance.filterData(filterSyntax: "correctAnswer = userAnswer")
//        var list = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '2'")
//        var list = PracticesDBManager.sharedInstance.filterData(filterSyntax: "level = '2'").filter { (question) -> Bool in
//            question.knowledgeArea == KnowledgeArea.ProjectScopeManagement.rawValue
//        }
        
        if PracticesDBManager.sharedInstance.getDataFromDB().count > 0 /*&& mainViewViewController.appDelegate.newlyLoggedIn == false*/{
            mainViewViewController.setupViewAfterLoadingData()
            return
        }
        if i>10 {
            mainViewViewController.hideSpinnerWithText()
            PracticesDBManager.sharedInstance.addArrayOfData(objects: practiceMainViewModel.practiceQuestions)
            mainViewViewController.setupViewAfterLoadingData()
            return
        }
        if i == 1{
            mainViewViewController.showSpinnerWithText()
        }
        
        mainViewViewController.appDelegate.newlyLoggedIn = true
        (interactor as! MainViewInteractor).callAllPracticeQuestions(params: ["level":"\(i)"],handler: { (model, error) in
            if error != nil {
                mainViewViewController.hideSpinnerWithText()
                (self.view as! MainViewViewController).showDefaultAlert(message: (error?.localizedDescription)!, popView: true)
                return
            }
            guard let success = (model as? PracticeMainDataModel)?.success else{
                return
            }
            
            if success{
                if mainViewViewController.appDelegate.isFreeVersion!{
                    mainViewViewController.hideSpinnerWithText()
                    self.prepareViewModel(dataModel: (model as! PracticeMainDataModel))
                    PracticesDBManager.sharedInstance.addArrayOfData(objects: self.practiceMainViewModel.practiceQuestions)
                    mainViewViewController.setupViewAfterLoadingData()
                    return
                }
                
                self.i = self.i + 1
                self.prepareViewModel(dataModel: (model as! PracticeMainDataModel))
                print("\(dataModel: (model as! PracticeMainDataModel).practiceQuestionsModelArray?.count)")
                self.callAllPracticeQuestions()
            }else{
                (self.view as! ProfileViewController).showDefaultAlert(message: (model as! ExamQuestionDataModel).reason!,popView: false)
                mainViewViewController.hideSpinner()
            }
        })
    }
    
    func prepareViewModel(dataModel:PracticeMainDataModel){
        var index = -1
        for question in dataModel.practiceQuestionsModelArray!{
            index += 1
            
            let practiceQuestionFull = PracticeQuestionFull()
            practiceQuestionFull.questionId = question.questionId!
            practiceQuestionFull.questionE = question.questionE
            practiceQuestionFull.questionA = question.questionA
            
            practiceQuestionFull.answerE1 = question.answerE1
            practiceQuestionFull.answerE2 = question.answerE2
            practiceQuestionFull.answerE3 = question.answerE3
            practiceQuestionFull.answerE4 = question.answerE4
            
            practiceQuestionFull.answerA1 = question.answerA1
            practiceQuestionFull.answerA2 = question.answerA2
            practiceQuestionFull.answerA3 = question.answerA3
            practiceQuestionFull.answerA4 = question.answerA4
            
            practiceQuestionFull.correctAnswer = question.correctAnswer
            practiceQuestionFull.processGroup = question.processGroup
            practiceQuestionFull.knowledgeArea = question.knowledgeArea
            
            practiceQuestionFull.level = question.level
            practiceQuestionFull.justificationE = question.justificationE
            practiceQuestionFull.justificationA = question.justificationA
            
            practiceQuestionFull.questionIndex = index
            
            practiceMainViewModel.practiceQuestions.append(practiceQuestionFull)
        }
    }
    
    func setLevelsUserDefaults(model: PracticeLevelsDataModel) {
        let defaults:UserDefaults = UserDefaults.standard
//        if let testValue = defaults.string(forKey: KnowledgeArea.ProjectIntegrationManagement.rawValue){
//            if testValue.count > 0{
//                return
//            }
//        }
        defaults.set(model.levelForProjectIntegrationManagement, forKey: "\(KnowledgeArea.ProjectIntegrationManagement.rawValue)")
        defaults.set(model.levelForProjectScopeManagement, forKey: "\(KnowledgeArea.ProjectScopeManagement.rawValue)")
        defaults.set(model.levelForProjectScheduleManagement, forKey: "\(KnowledgeArea.ProjectScheduleManagement.rawValue)")
        defaults.set(model.levelForProjectCostManagement, forKey: "\(KnowledgeArea.ProjectCostManagement.rawValue)")
        defaults.set(model.levelForProjectQualityManagement, forKey: "\(KnowledgeArea.ProjectQualityManagement.rawValue)")
        defaults.set(model.levelForProjectResourceManagement, forKey: "\(KnowledgeArea.ProjectResourceManagement.rawValue)")
        defaults.set(model.levelForProjectCommunicationsManagement, forKey: "\(KnowledgeArea.ProjectCommunicationsManagement.rawValue)")
        defaults.set(model.levelForProjectRiskManagement, forKey: "\(KnowledgeArea.ProjectRiskManagement.rawValue)")
        defaults.set(model.levelForProjectProcurementManagement, forKey: "\(KnowledgeArea.ProjectProcurementManagement.rawValue)")
        defaults.set(model.levelForProjectStakeholderManagement, forKey: "\(KnowledgeArea.ProjectStakeholderManagement.rawValue)")
        
        defaults.set(model.levelForInitiatingProcessGroup, forKey: "\(ProcessGroup.InitiatingProcessGroup.rawValue)")
        defaults.set(model.levelForExecutingProcessGroup, forKey: "\(ProcessGroup.PlanningProcessGroup.rawValue)")
        defaults.set(model.levelForExecutingProcessGroup, forKey: "\(ProcessGroup.ExecutingProcessGroup.rawValue)")
        defaults.set(model.levelForMonitoringControllingProcessGroup, forKey: "\(ProcessGroup.MonitoringAndControllingProcessGroup.rawValue)")
        defaults.set(model.levelForClosingProcessGroup, forKey: "\(ProcessGroup.ClosingProcessGroup.rawValue)")
    }
    
    func setLevelsAllToOne() {
        let defaults:UserDefaults = UserDefaults.standard
        //        if let testValue = defaults.string(forKey: KnowledgeArea.ProjectIntegrationManagement.rawValue){
        //            if testValue.count > 0{
        //                return
        //            }
        //        }
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectIntegrationManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectScopeManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectScheduleManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectCostManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectQualityManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectResourceManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectCommunicationsManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectRiskManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectProcurementManagement.rawValue)")
        defaults.set("1", forKey: "\(KnowledgeArea.ProjectStakeholderManagement.rawValue)")
        
        defaults.set("1", forKey: "\(ProcessGroup.InitiatingProcessGroup.rawValue)")
        defaults.set("1", forKey: "\(ProcessGroup.PlanningProcessGroup.rawValue)")
        defaults.set("1", forKey: "\(ProcessGroup.ExecutingProcessGroup.rawValue)")
        defaults.set("1", forKey: "\(ProcessGroup.MonitoringAndControllingProcessGroup.rawValue)")
        defaults.set("1", forKey: "\(ProcessGroup.ClosingProcessGroup.rawValue)")
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

extension MainViewPresenter: MainViewPresentation {
    // TODO: implement presentation methods
}

extension MainViewPresenter: MainViewInteractorOutput {
    // TODO: implement interactor output methods
}
