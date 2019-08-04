//
//  ExamOptionsViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/7/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

enum TimerType {
    case PerQuestion
    case PerExam
}

class ExamOptionsViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var presenter: ExamOptionsPresentation?
    @IBOutlet weak var submitView: SubmitButtonView!
    var timepickerView = UIPickerView()
    var timeTypepickerView = UIPickerView()
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    var timerType : TimerType?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: Lifecycle

    override func viewDidLoad() {        
        super.viewDidLoad()
        presenter = ExamOptionsPresenter()
        (presenter as! ExamOptionsPresenter).view = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.submitView.submitButton.addTarget(self, action: #selector(showExam), for: UIControlEvents.touchUpInside)
        self.submitView.submitButton.setTitle("START EXAM", for: .normal)
        self.submitView.submitButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.submitView.submitButton.backgroundColor = UIColor.lightGray
        self.submitView.submitButton.isUserInteractionEnabled = false

        tableView.register(UINib(nibName: InputSectionViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: InputSectionViewCell.identifier)
        
//        pickerView.datePickerMode = .time
//        pickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        timepickerView.delegate = self
        timeTypepickerView.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        (self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func showExam()  {
        let examQuestionViewController = ExamQuestionRouter.setupModule()
        examQuestionViewController.timerType = timerType
        var dateComp = DateComponents()
        dateComp.hour = hour
        dateComp.minute = minutes
        examQuestionViewController.dateComp = dateComp
        examQuestionViewController.numberOfQuestions = Int((self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!)!
        self.navigationController?.pushViewController(examQuestionViewController, animated: true)
    }
    
    func validateWholeView() {
        if (self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!.count > 0 &&
            Int((self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!)! < 250 && (self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!.count > 0 && (self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!.count > 0{
            self.submitView.submitButton.setTitleColor(UIColor.white, for: .normal)
            self.submitView.submitButton.backgroundColor = UIColor.PMPYellow
            self.submitView.submitButton.isUserInteractionEnabled = true
        }else{
            self.submitView.submitButton.setTitleColor(UIColor.darkGray, for: .normal)
            self.submitView.submitButton.backgroundColor = UIColor.lightGray
            self.submitView.submitButton.isUserInteractionEnabled = false
        }
    }
}

extension ExamOptionsViewController: ExamOptionsView {
    // TODO: implement view output methods
}

extension ExamOptionsViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Exam"
    }
}

extension ExamOptionsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputSectionViewCell.identifier) as! InputSectionViewCell
        
        cell.configureCell(inputModel: (presenter as! ExamOptionsPresenter).prepareDataModels()[indexPath.row])
        cell.inputSectionView.imageView.isHidden = true
        cell.delegate = self
        if indexPath.row == 0 {
            if appDelegate.isFreeVersion!{
                cell.inputSectionView.inputTextField.isUserInteractionEnabled = false
                cell.inputSectionView.highlightedView.backgroundColor = UIColor.PMPgray
                cell.inputSectionView.inputTextField.text = "25"
            }
            cell.inputSectionView.inputTextField.keyboardType = UIKeyboardType.asciiCapableNumberPad
        }
        else if indexPath.row == 1{
            cell.inputSectionView.inputTextField.inputView = timeTypepickerView
        }else if indexPath.row == 2{
            cell.inputSectionView.inputTextField.inputView = timepickerView
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ExamOptionsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ExamOptionsViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == timepickerView{
            return 2//3
        }else{
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == timepickerView{
            switch component {
            case 0:
                return 24
            case 1/*,2*/:
                return 60
                
            default:
                return 0
            }
        }else{
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView == timepickerView{
            return pickerView.frame.size.width/2 //3
        }else{
            return pickerView.frame.size.width
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == timepickerView{
            switch component {
            case 0:
                return "\(row) Hour"
            case 1:
                return "\(row) Minute"
    //        case 2:
    //            return "\(row) Second"
            default:
                return ""
            }
        }else{
            if row == 0{
                timerType = .PerQuestion
                return "Time For Question"
            }else{
                timerType = .PerExam
                return "Time For Whole Exam"
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == timepickerView{
        
            switch component {
            case 0:
                self.hour = row 
                (self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text = "\(hour) hour and \(minutes) minutes"
                self.validateWholeView()
            case 1:
                minutes = row
                (self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text = "\(hour) hour and \(minutes) minutes"
                self.validateWholeView()
    //        case 2:
    //            seconds = row
            default:
                break;
            }
        }else{
            if row == 0{
                (self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text = "Time For Question"
            }else{
                (self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text = "Time For Whole Exam"
            }
            self.validateWholeView()
        }
    }
}

extension  ExamOptionsViewController : InputSectionViewCellDelegate {
    func didStartEditingTextField(inputSectionView:InputSectionView){
        self.validateWholeView()
    }
    func didFinishEditingTextField(inputSectionView:InputSectionView){
        self.validateWholeView()
    }
}
