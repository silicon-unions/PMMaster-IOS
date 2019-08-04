//
//  ForgotPasswordViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties
    
    var presenter: ForgotPasswordPresentation!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitView: SubmitButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ForgotPasswordPresenter()
        (presenter as! ForgotPasswordPresenter).view = self
//        forgotPasswordPresenter.attachView(view: self.view)
        
        tableView.register(UINib(nibName: InputSectionViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: InputSectionViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        submitView.submitButton.setTitle("SEND", for: UIControlState.normal)
        
        descriptionLabel.text = "Please write  your email here to send you an email with a password reset link"
        
        
        submitView.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: UIControlEvents.touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func submitButtonPressed() {
        
        let isValid = self.validateAllEntries()
        print(isValid)
        guard isValid else {
            return
        }
        
        self.presenter.submitForgotPassword(email: (self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!)
    }
    
    func validateAllEntries() -> Bool{
        for i in 0...0{
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as! InputSectionViewCell
            
            
            let expressionTest = NSPredicate(format:"SELF MATCHES %@", (self.presenter as! ForgotPasswordPresenter).inputDataModels![i].regularExpression!)
            if !expressionTest.evaluate(with: cell.inputSectionView.inputTextField.text){
                return false
            }
        }
        return true
    }
    
    override func viewDidLayoutSubviews() {
//        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ForgotPasswordViewController: ForgotPasswordView {
    // TODO: implement view output methods
}


extension ForgotPasswordViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputSectionViewCell.identifier) as! InputSectionViewCell

        cell.configureCell(inputModel: presenter.prepareViewModel()[indexPath.row])
        return cell
    }
}
extension ForgotPasswordViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
