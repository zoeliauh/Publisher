//
//  ViewController.swift
//  Publisher
//
//  Created by woanjwu liauh on 2021/10/12.
//

import UIKit
import Firebase
import FirebaseFirestore

class PublishPageViewController: UIViewController, UITextFieldDelegate {
    
    var db: Firestore!
    
    @IBOutlet weak var inputTitleTextField: UITextField!
    
    @IBOutlet weak var inputCatagoryTextField: UITextField!
        
    @IBOutlet weak var inputContentTextView: UITextView!
    
    @IBOutlet weak var inputPublishButton: UIButton!
    
    var titleText: String = ""
    
    var catalogText: String = ""
    
    var contentText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        inputContentTextView.text = ""
    }

    @IBAction func inputPublishButtonPressed(_ sender: UIButton!) {
        addData()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - post data on firebase
   func addData() {
   let articles = Firestore.firestore().collection("articles")
   let document = articles.document()
   let data: [String: Any] = [
    "author": [
        "email": "wayne@school.appworks.tw",
        "id": "waynechen323",
            "name": "AKA老師"
   ],
    "title": inputTitleTextField.text!,
    "content": inputContentTextView.text!,
   "createdTime": NSDate().timeIntervalSince1970,
   "id": document.documentID,
    "category": inputCatagoryTextField.text!
   ]
   document.setData(data) }
}

