//
//  DailyTransactionsViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 8/31/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class DailyTransactionsViewController: BaseViewController {

    // MARK: Properties

    var presenter: DailyTransactionsPresentation?
    var dailyArray = [DateQuestionsTransactions]()
    @IBOutlet weak var tableView: UITableView!
    // MARK: Lifecycle
    @IBOutlet weak var noQuestionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        noQuestionsLabel.isHidden = true
        
        dailyArray = DateDBManager.sharedInstance.getTransactionsFromDB()
        
        if dailyArray.count < 1{
            self.tableView.isHidden = true
            noQuestionsLabel.isHidden = false
        }
    }
}

extension DailyTransactionsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"dailyCellID")
        
        (cell?.viewWithTag(5) as! UILabel).text = "\(dailyArray[dailyArray.count - indexPath.row - 1].correctCount)"
        (cell?.viewWithTag(6) as! UILabel).text = dailyArray[dailyArray.count - indexPath.row - 1].date
        (cell?.viewWithTag(7) as! UILabel).text = "\(dailyArray[dailyArray.count - indexPath.row - 1].wrongCount)"
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension DailyTransactionsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension DailyTransactionsViewController: DailyTransactionsView {
    // TODO: implement view output methods
}

extension DailyTransactionsViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "MainView"
    }
}
