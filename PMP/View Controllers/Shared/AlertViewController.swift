//
//  AlertViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/11/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

protocol AlertViewControllerDelegate{
    func okButtonPressed(type:DialogType)
    func cancelButtonPressed(type:DialogType)
}

enum DialogType{
    case submitExam
    case congratulations
    case upgrade
    case confirmBack
}
class AlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var longOkButton: UIButton!
    
    var isOnlyOneButton = false
    var okButtonTitle = "OK"
    
    var titleText : String?
    var bodyText : String?
    var delegate : AlertViewControllerDelegate?
    var dialogType : DialogType = .submitExam
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isOnlyOneButton == true {
            okButton.isHidden = true
            cancelButton.isHidden = true
            longOkButton.isHidden = false
        }
        if titleText != nil{
            self.titleLabel.text = titleText!
        }

        self.bodyLabel.text = bodyText
        self.okButton.setTitle(okButtonTitle, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ok(_ sender: Any) {
        delegate?.okButtonPressed(type: dialogType)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        delegate?.cancelButtonPressed(type: dialogType)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func longOkPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
