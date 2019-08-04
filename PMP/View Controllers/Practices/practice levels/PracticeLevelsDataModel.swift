//
//  PracticeLevelsDataModel.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/28/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import Gloss

class PracticeLevelsDataModel: AppBaseModel {
    var levelForInitiatingProcessGroup : String?
    var levelForPlanningProcessGroup : String?
    var levelForExecutingProcessGroup : String?
    var levelForMonitoringControllingProcessGroup : String?
    var levelForClosingProcessGroup : String?
    var levelForProjectIntegrationManagement : String?
    var levelForProjectScopeManagement : String?
    var levelForProjectScheduleManagement : String?
    var levelForProjectCostManagement : String?
    var levelForProjectQualityManagement : String?
    var levelForProjectResourceManagement : String?
    var levelForProjectCommunicationsManagement : String?
    var levelForProjectRiskManagement : String?
    var levelForProjectProcurementManagement : String?
    var levelForProjectStakeholderManagement : String?
    
    required init?(json: JSON){
        
        self.levelForInitiatingProcessGroup = "levels.Initiating Process Group" <~~ json
        self.levelForPlanningProcessGroup = "levels.Planning Process Group" <~~ json
        self.levelForExecutingProcessGroup = "levels.Executing Process Group" <~~ json
        self.levelForMonitoringControllingProcessGroup = "levels.Monitoring and Controlling Process Group" <~~ json
        self.levelForClosingProcessGroup = "levels.Closing Process Group" <~~ json
        self.levelForProjectIntegrationManagement = "levels.Project integration management" <~~ json
        self.levelForProjectScopeManagement = "levels.Project scope management" <~~ json
        self.levelForProjectScheduleManagement = "levels.Project schedule management" <~~ json
        self.levelForProjectCostManagement = "levels.Project cost management" <~~ json
        self.levelForProjectQualityManagement = "levels.Project quality management" <~~ json
        self.levelForProjectResourceManagement = "levels.Project resource management" <~~ json
        self.levelForProjectCommunicationsManagement = "levels.Project communications management" <~~ json
        self.levelForProjectRiskManagement = "levels.Project risk management" <~~ json
        self.levelForProjectProcurementManagement = "levels.Project procurement management" <~~ json
        self.levelForProjectStakeholderManagement = "levels.Project stakeholder management" <~~ json
        
        super.init(json: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func toJSON() -> JSON? {
        return jsonify([
            "Initiating Process Group" ~~> self.levelForInitiatingProcessGroup,
            "Planning Process Group" ~~> self.levelForPlanningProcessGroup,
            "Executing Process Group" ~~> self.levelForExecutingProcessGroup,
            "Monitoring and Controlling Process Group" ~~> self.levelForMonitoringControllingProcessGroup,
            "Closing Process Group" ~~> self.levelForClosingProcessGroup,
            "Project integration management" ~~> self.levelForProjectIntegrationManagement,
            "Project scope management" ~~> self.levelForProjectScopeManagement,
            "Project schedule management" ~~> self.levelForProjectScheduleManagement,
            "Project cost management" ~~> self.levelForProjectCostManagement,
            "Project quality management" ~~> self.levelForProjectQualityManagement,
            "Project resource management" ~~> self.levelForProjectResourceManagement,
            "Project communications management" ~~> self.levelForProjectCommunicationsManagement,
            "Project risk management" ~~> self.levelForProjectRiskManagement,
            "Project procurement management" ~~> self.levelForProjectProcurementManagement,
            "Project stakeholder management" ~~> self.levelForProjectStakeholderManagement
            ])

    }
}

