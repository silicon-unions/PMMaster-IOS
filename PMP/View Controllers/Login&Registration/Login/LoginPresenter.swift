//
//  LoginPresenter.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class LoginPresenter: BasePresenter {
    
    var inputDataModels:  [InputSectionViewCell.InputSectionModel]?

    func prepareDataModels() -> [InputSectionViewCell.InputSectionModel]{
        inputDataModels?.removeAll()
        inputDataModels =  [InputSectionViewCell.InputSectionModel]()
        
        let emailModel = InputSectionViewCell.InputSectionModel.init(titleString: "Email", textFieldPlaceHolder: "Enter your email", hintMsgString: "", errorMsgeString: "invalid email format" , regularExpression: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
//        let emailModel = InputSectionViewCell.InputSectionModel()
//        emailModel.titleString = "Email"
//        emailModel.textFieldPlaceHolder = "Enter your email"
//        emailModel.hintMsgString = ""
//        emailModel.errorMsgeString = "invalid email"
//        emailModel.regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        emailModel.isValidEntry = false
        
        let passwordModel = InputSectionViewCell.InputSectionModel.init(titleString: "Password", textFieldPlaceHolder: "Enter your password", hintMsgString: "", errorMsgeString: "invalid password", regularExpression: "^[a-zA-Z0-9@#$*@!%^&{}<> ]{6,15}")

//        let passwordModel = InputSectionViewCell.InputSectionModel()
//        passwordModel.titleString = "Password"
//        passwordModel.textFieldPlaceHolder = "Enter your password"
//        passwordModel.hintMsgString = ""
//        passwordModel.errorMsgeString = "invalid password"
//        passwordModel.regularExpression = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
//        passwordModel.isValidEntry = false
        
        
        inputDataModels?.append(emailModel)
        inputDataModels?.append(passwordModel)
        
        return inputDataModels!
    }
}
