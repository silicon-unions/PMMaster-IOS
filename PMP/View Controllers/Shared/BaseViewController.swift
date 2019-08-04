//
//  BaseViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/17/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func UpdateQuestionTransaction(correct:Int,wrong:Int) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        
        if let todayTransaction = DateDBManager.sharedInstance.getTransactionsWithdate(date: dateString){
            DateDBManager.sharedInstance.updateData(date: todayTransaction.date!, correct: correct, wrong: wrong)
        }else{
            let todayNewTransaction = DateQuestionsTransactions()
            todayNewTransaction.date = dateString
            todayNewTransaction.correctCount = correct
            todayNewTransaction.wrongCount = wrong
            
            DateDBManager.sharedInstance.addData(object: todayNewTransaction)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSpinner()  {
        Spinner.showActivityIndicator(forView: self.view)
    }
    func showSpinnerWithText()  {
        Spinner.showActivityIndicatorWithText(forView: self.view)
    }
    
    func hideSpinner(){
        Spinner.hideActivityIndicator(forView: self.view)
    }
    func hideSpinnerWithText(){
        Spinner.hideActivityIndicatorWithText(forView: self.view)
    }
    
    func showDefaultAlert(message : String, popView : Bool)  {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if popView{
                self.navigationController?.popViewController(animated: true)
            }
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDefaultAlert(message : String, dismissView : Bool)  {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if dismissView{
                self.dismiss(animated: true, completion: nil)
            }
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showList() {
//        let listVC = MainListRouter.setupModule()
//        listVC.navController = self.navigationController
//        self.navigationController?.present(listVC, animated: true, completion: nil)
        
        MainViewRouter.showMainList(navigation: self.navigationController!)
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
