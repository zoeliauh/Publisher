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

    
//    @IBOutlet weak var publishButton: UIButton!
    
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        publishTableView.delegate = self
        publishTableView.dataSource = self
    }
    
//    @IBAction func publishButtonPressed(_ sender: Any) {
//        
//        
//    }

}

// MARK: - TableViewDataSource
extension HomePageViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtitleTableViewCell", for: indexPath) as? ArtitleTableViewCell else { fatalError("can not dequeue cell") }
        
        cell.articleTitleLabel.text = "articleTitle"
        
        return cell
        
    }
    
    
    
    
    
}

// MARK: - TableViewDelegate
extension HomePageViewController: UITableViewDelegate {
    
    
    
}
