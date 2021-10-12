//
//  HomePageViewController.swift
//  Publisher
//
//  Created by woanjwu liauh on 2021/10/12.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var publishTableView: UITableView!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        publishTableView.delegate = self
        publishTableView.dataSource = self
        
        getRealTimePublish()
    }
    
    var publishList = PublishList(author: "", title: "", id: "", catagory: "", contents: "", createdTime: FieldValue.serverTimestamp())
    
    var publishLists: [Any] = []
    
    
    @IBAction func publishButtonPressed(_ sender: Any) {
        
        
    }
    
    func getRealTimePublish() {
        
        publishLists = []
        
        db.collection("data").addSnapshotListener{ [self] (queryDocumentSnapshot, error) in
            guard let documents = queryDocumentSnapshot?.documents else {
                print("no document")
                return
            }
            
            publishLists = []
            
            documents.forEach { document in
                guard let author = document.get("author") as? String else {
                    print("")
                    return
                }
                
                if author == "AKA小安老師" {
                    print(document.data())
                    publishLists.append(author)
                }
            }
        }
    }
}

// MARK: - TableViewDataSource
extension HomePageViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtitleTableViewCell", for: indexPath) as? ArtitleTableViewCell else { fatalError("can not dequeue cell") }
        
        cell.articleTitleLabel.text = "articleTitle"
        cell.authorNameLabel.text = "Wayne Chen"
        cell.createdTimeLabel.text = "\(NSDate().timeIntervalSince1970)"
        cell.catagoryLabel.text = "beauty"
        cell.artitleContentTextView.text = "contentcontentcontentcontentcontentcontent"
        
        return cell
        
    }
    
    
    
    
    
}

// MARK: - TableViewDelegate
extension HomePageViewController: UITableViewDelegate {
    
    
    
}
