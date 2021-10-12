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
        
        getRealTimePublishLists()
        readPublishLists()
    }

    var publishList = PublishList(author: [], title: "", id: "", catagory: "", contents: "")
    
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
        
        db.collection("articles").getDocuments { [self] snapshot, eror in
            guard let snapshot = snapshot else { return }
            
            titleLists = []

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
    }
    
    // MARK: - get real time data from firebase
    func getRealTimePublishLists() {
                
        db.collection("articles").addSnapshotListener{ [self] (queryDocumentSnapshot, error) in
            guard let documents = queryDocumentSnapshot?.documents else {
                print("no document")
                return
            }

            titleLists = []
            categoryList = []
            contentLists = []
            
            documents.forEach { document in
                                
                print(document.data())
                
//                publishLists.append(document.data())
                
                guard let title = document.get("title") as? String else {
                    print("can't get title")
                    return
                }
                
                guard let content = document.get("content") as? String else {
                    print("can't get content")
                    return
                }
                
                guard let category = document.get("category") as? String else {
                    print("can't get category")
                    return
                }
                
                titleLists.append(title)
                categoryList.append(category)
                contentLists.append(content)
            }
            print("===========================================")
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
