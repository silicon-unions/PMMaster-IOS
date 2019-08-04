//
//  VFPSDetailsTVCell.swift
//  MyVodafone
//
//  Created by Amr Allam on 11/29/17.
//  Copyright © 2017 TSSE. All rights reserved.
//

import UIKit

protocol InputSectionViewCellDelegate {
    func didStartEditingTextField(inputSectionView:InputSectionView)
    func didFinishEditingTextField(inputSectionView:InputSectionView)
}

class InputSectionViewCell: UITableViewCell {
    
    struct InputSectionModel {
        var titleString : String?
        var textFieldPlaceHolder : String?
        var hintMsgString : String = ""
        var errorMsgeString : String?
        var regularExpression : String?
    }

    static let identifier = "InputSectionViewCell"
    static let nibName = "InputSectionViewCell"
    @IBOutlet weak var inputSectionView: InputSectionView!
    var model : InputSectionModel!
    var delegate : InputSectionViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(inputModel : InputSectionModel) {
        model = inputModel
//        self.inputSectionView.titleLabel.text = inputModel.titleString
        self.inputSectionView.inputTextField.placeholder = inputModel.textFieldPlaceHolder
        self.inputSectionView.messageLabel.text = ""
        self.inputSectionView.inputTextField.delegate = self
        self.inputSectionView.changeDisplayMode(mode: .normal)
    }
    
    func validate(inputModel : InputSectionModel) -> Bool {
        let expressionTest = NSPredicate(format:"SELF MATCHES %@", inputModel.regularExpression!)
        return expressionTest.evaluate(with: self.inputSectionView.inputTextField.text)
        
    }
    
    func validate() -> Bool {
        let expressionTest = NSPredicate(format:"SELF MATCHES %@", model.regularExpression!)
        return expressionTest.evaluate(with: self.inputSectionView.inputTextField.text)
        
    }
}

extension InputSectionViewCell : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        self.inputSectionView.changeDisplayMode(mode: .highlighted)
        self.inputSectionView.messageLabel.text = ""
        delegate?.didStartEditingTextField(inputSectionView: self.inputSectionView)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        delegate?.didFinishEditingTextField(inputSectionView: self.inputSectionView)
        if self.validate(inputModel: model){
            self.inputSectionView.changeDisplayMode(mode: .normal)
            self.inputSectionView.messageLabel.text = ""
        }else{
            self.inputSectionView.changeDisplayMode(mode: .error)
            self.inputSectionView.messageLabel.text = model.errorMsgeString
        }
        
        return true
    }
}
