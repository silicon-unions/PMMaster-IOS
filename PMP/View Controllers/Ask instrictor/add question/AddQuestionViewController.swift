//
//  AddQuestionViewController.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/23/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation
import UIKit

class AddQuestionViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var askButton: UIButton!
    
    
    var presenter: AddQuestionPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = AddQuestionPresenter()
        (self.presenter as! AddQuestionPresenter).view = self
        
        textView.delegate = self
        textView.text = "Your question here..."
        textView.textColor = UIColor.lightGray
        askButton.setTitleColor(UIColor.PMPBlue, for: .normal)
        cancelButton.setTitleColor(UIColor.PMPBlue, for: .normal)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @IBAction func ask(_ sender: Any) {
        (self.presenter as! AddQuestionPresenter).callAddQuestion()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddQuestionViewController: AddQuestionView {
    // TODO: implement view output methods
}

extension AddQuestionViewController : StoryboardLoadable{
    static func storyboardName() -> String {
        return "AskInstructor"
    }
}

extension AddQuestionViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your question here..."
            textView.textColor = UIColor.lightGray
        }
    }
}
