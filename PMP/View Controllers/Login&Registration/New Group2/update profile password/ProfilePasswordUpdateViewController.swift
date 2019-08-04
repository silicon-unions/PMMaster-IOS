//
//  ProfilePasswordUpdateViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 7/6/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class ProfilePasswordUpdateViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitView: SubmitButtonView!
    
    var presenter: ProfilePasswordUpdatePresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePasswordUpdatePresenter()
        (presenter as! ProfilePasswordUpdatePresenter).view = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.submitView.submitButton.addTarget(self, action: #selector(updatePassword), for: UIControlEvents.touchUpInside)
        self.submitView.submitButton.setTitle("UPDATE PASSWORD", for: .normal)
        self.submitView.submitButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.submitView.submitButton.backgroundColor = UIColor.lightGray
        self.submitView.submitButton.isUserInteractionEnabled = false
        
        tableView.register(UINib(nibName: InputSectionViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: InputSectionViewCell.identifier)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func updatePassword() {
        (presenter as! ProfilePasswordUpdatePresenter).callUpdateProfile(params: ["password":(self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text!])
    }
}

extension ProfilePasswordUpdateViewController: ProfilePasswordUpdateView {
    // TODO: implement view output methods
}

extension ProfilePasswordUpdateViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "Profile"
    }
}

extension ProfilePasswordUpdateViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputSectionViewCell.identifier) as! InputSectionViewCell
        
        cell.configureCell(inputModel: (presenter as! ProfilePasswordUpdatePresenter).prepareDataModels()[indexPath.row])
        cell.delegate = self
        cell.inputSectionView.imageView.image = #imageLiteral(resourceName: "password image")
        return cell
    }
}
extension ProfilePasswordUpdateViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ProfilePasswordUpdateViewController : InputSectionViewCellDelegate{
    func didFinishEditingTextField(inputSectionView:InputSectionView){
        if (self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text! == (self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! InputSectionViewCell).inputSectionView.inputTextField.text! &&
            (self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InputSectionViewCell).validate() &&
            (self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! InputSectionViewCell).validate()
            {
            self.submitView.submitButton.setTitleColor(UIColor.white, for: .normal)
            self.submitView.submitButton.backgroundColor = UIColor.PMPYellow
            self.submitView.submitButton.isUserInteractionEnabled = true
        }
    }
    func didStartEditingTextField(inputSectionView:InputSectionView){
        
    }
}
