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
    
    let date = Date(timeIntervalSince1970: TimeInterval(NSDate().timeIntervalSince1970))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        publishTableView.delegate = self
        publishTableView.dataSource = self
        
        readPublishLists()
//        getRealTimePublishLists()
    }

    var publishList = PublishList(author: [], title: "", id: "", catagory: "", contents: "") {
        didSet {
            publishTableView.reloadData()
        }
    }
    
    var author = Author()
    
    var publishLists: [[String : Any]]  = []
    
    var titleLists: [String] = [] {
        didSet {
            publishTableView.reloadData()
        }
    }
    
    var contentLists: [String] = []
    
    var categoryList: [String] = []
    
    @IBAction func publishButtonPressed(_ sender: Any) {
        
        // present to PublishPage by segue
    }
    
    // MARK: - read the data from firebase
    func readPublishLists() {
//        titleLists = []
        
        db.collection("articles").getDocuments { [self] snapshot, eror in
            guard let snapshot = snapshot else { return }
            if snapshot.documents.isEmpty {
                print("no match doc")
            } else {
                for i in snapshot.documents {
                    publishLists.append(i.data())
                    
                    guard let title = i.get("title") as? String else {
                        return
                    }
                    
                    guard let content = i.get("content") as? String else {
                        return
                    }
                    
                    guard let category = i.get("category") as? String else {
                        return
                    }
                    titleLists.append(title)
                    contentLists.append(content)
                    categoryList.append(category)
                }
            }
        }
        publishTableView.reloadData()
    }
    
    // MARK: - get real time data from firebase
    func getRealTimePublishLists() {
        
//        publishLists = []
        
        db.collection("articles").addSnapshotListener{ [self] (queryDocumentSnapshot, error) in
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
                    print("AKA小安老師")
//                    publishLists.append(author)
                }
            }
        }
    }
}

// MARK: - TableViewDataSource
extension HomePageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtitleTableViewCell", for: indexPath) as? ArtitleTableViewCell else { fatalError("can not dequeue cell") }
        
        cell.articleTitleLabel.text = titleLists[indexPath.row]
        cell.authorNameLabel.text = "Wayne Chen"
        cell.createdTimeLabel.text = "\(date)"
        cell.catagoryLabel.text = categoryList[indexPath.row]
        cell.artitleContentTextView.text = contentLists[indexPath.row]
        
        return cell
    }
}

// MARK: - TableViewDelegate
extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
