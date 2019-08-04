//
//  GenYPickerViewController.swift
//  smartbanking
//
//  Created by Administrator on 11/15/16.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

extension Date {
    var localizedDescription: String {
        return description(with: .current)
    }
}


protocol GenYPickerDelegate: class {
    func didSelect(value: String, selectedIndex: Int, for picker: GenYPickerViewController)
    func didSelect(date: Date, for picker: GenYPickerViewController)
}

extension GenYPickerDelegate {
    func didSelect(value: String, selectedIndex: Int, for picker: GenYPickerViewController) {}
    func didSelect(date: Date, for picker: GenYPickerViewController) {}
}

enum GenYPickerType {
    case MaskedView
    case View
    case Date
}

class GenYPickerViewController: UIViewController {
    
    @IBOutlet fileprivate weak var cancelButton: UIButton!
    @IBOutlet fileprivate weak var doneButton: UIButton!
    @IBOutlet fileprivate weak var controlView: UIView!
    @IBOutlet fileprivate weak var controlPanel: UIView!
    @IBOutlet fileprivate weak var picker: UIPickerView?
    @IBOutlet var datePicker: UIDatePicker?
    
    var selectedPickerType: GenYPickerType?
    
    fileprivate var dataSource = [String]()
    fileprivate var datePickerMode: UIDatePickerMode = .dateAndTime
    fileprivate var delegate: GenYPickerDelegate?
    
    var tag: Int = -1
    
    var allowPanelTransparency: Bool = false
    
    
    static func instantiate(withType type: GenYPickerType) -> GenYPickerViewController {
        var pickerIdentifier = ""
        switch type {
            case .MaskedView: pickerIdentifier = "GenYPickerTypeMaskedView"
            case .View: pickerIdentifier = "GenYPickerTypeView"
            case .Date: pickerIdentifier = "GenYPickerTypeDate"
        }
        

        
        let storyboard = UIStoryboard(name: "GenYPicker", bundle: nil)
        let pickerVc = storyboard.instantiateViewController(withIdentifier: pickerIdentifier) as! GenYPickerViewController
        pickerVc.selectedPickerType = type
        return pickerVc
    }
    
    func picker(withDataSource dataSource: [String], delegate: GenYPickerDelegate?) {
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    func picker(withDatePickerMode datePickerMode: UIDatePickerMode, delegate: GenYPickerDelegate?) {
        self.datePickerMode = datePickerMode
        self.delegate = delegate
    }
    
    func picker(withDatePickerMode datePickerMode: UIDatePickerMode, delegate: GenYPickerDelegate? , date: Date) {
        self.datePickerMode = datePickerMode
        self.delegate = delegate
        self.datePicker?.date = date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupTheme()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if selectedPickerType == .MaskedView {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if selectedPickerType == .MaskedView {
            UIApplication.shared.statusBarStyle = .default
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupView() {
        if let type = selectedPickerType {
            switch type {
                case .View, .MaskedView: picker?.reloadAllComponents()
                case .Date: datePicker?.datePickerMode = datePickerMode
                
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupTheme() {
//        cancelButton.setTitleColor(UIColor.blue, for: .normal)
//        doneButton.setTitleColor(UIColor.blue, for: .normal)
//        controlPanel.backgroundColor = allowPanelTransparency ? UIColor.white : GenYThemeConstants.uiElementLight2ThemeColor
//        controlView.backgroundColor = allowPanelTransparency ? GenYAppStylingKit.GenYColor.clear.color : GenYAppStylingKit.GenYColor.white.color
    }
    @objc func dismissPicker() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: UIButton) {
        dismissPicker()
    }
    
    @IBAction func doneTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let type = selectedPickerType {
            switch type {
            case .View, .MaskedView:
                if let rowNumber = picker?.selectedRow(inComponent: 0) {
                    let text = dataSource[rowNumber]
                    delegate?.didSelect(value: text, selectedIndex: rowNumber, for: self)
                }
            case .Date:
                if let date = datePicker?.date {
                    delegate?.didSelect(date: date, for: self)
                }
            }
        }
    }
}

extension GenYPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
}

extension GenYPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = dataSource[row]
        if let rowNumber = picker?.selectedRow(inComponent: 0){
            if rowNumber == 0 && row == 0{
            }
            else{
            }
        }
        
//        if let rowNumber = picker?.selectedRow(inComponent: 0){
//            if rowNumber == row{
//                label.font = UIFont(name: FONT.Bold.rawValue, size: 15)
//            }else{
//                label.font = UIFont(name: FONT.Regular.rawValue, size: 15)
//            }
//        }
        
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row != 0 {
            pickerView.reloadComponent(0)
        }
        
        if let label = pickerView.view(forRow: row, forComponent: component) as? UILabel {
//            label.font = UIFont(name: FONT.Bold.rawValue, size: 16)
        }
        

        
//        for i in 0...pickerView.numberOfComponents{
//            if i == row{
//                continue
//            }else{
//                if let label = pickerView.view(forRow: i, forComponent: component) as? UILabel {
//                    label.font = UIFont(name: FONT.Regular.rawValue, size: 15)
//                }
//            }
//        }

    }
}



