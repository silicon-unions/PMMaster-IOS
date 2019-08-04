//
//  ExamOptionsPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/7/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

class ExamOptionsPresenter {

    // MARK: Properties

    var view: ExamOptionsView?
    var router: ExamOptionsWireframe?
    var interactor: ExamOptionsUseCase?
    
    var inputDataModels:  [InputSectionViewCell.InputSectionModel]?
    
    func prepareDataModels() -> [InputSectionViewCell.InputSectionModel]{
        
        inputDataModels?.removeAll()
        inputDataModels =  [InputSectionViewCell.InputSectionModel]()
        
        let questionsNumberModel = InputSectionViewCell.InputSectionModel.init(titleString: "Questions Number", textFieldPlaceHolder: "set questions number", hintMsgString: "", errorMsgeString: "Max. number of questions is 250" , regularExpression: "([1-9]|[1-8][0-9]|9[0-9]|1[0-9]{2}|2[0-4][0-9]|250)")
        
        let timeTypeModel = InputSectionViewCell.InputSectionModel.init(titleString: "Timer Type", textFieldPlaceHolder: "please select timer type", hintMsgString: "", errorMsgeString: "please select time type", regularExpression: "^[a-zA-Z0-9@#$*@!%^&{}<> ]{1,500}")
        
        let timeModel = InputSectionViewCell.InputSectionModel.init(titleString: "Choose Time", textFieldPlaceHolder: "select time", hintMsgString: "", errorMsgeString: "please pick time", regularExpression: "^[a-zA-Z0-9@#$*@!%^&{}<> ]{1,500}")
        
        
        inputDataModels?.append(questionsNumberModel)
        inputDataModels?.append(timeTypeModel)
        inputDataModels?.append(timeModel)
        
        return inputDataModels!
    }
}

extension ExamOptionsPresenter: ExamOptionsPresentation {
    // TODO: implement presentation methods
}

extension ExamOptionsPresenter: ExamOptionsInteractorOutput {
    // TODO: implement interactor output methods
}
