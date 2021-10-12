//
//  PublishModel.swift
//  Publisher
//
//  Created by woanjwu liauh on 2021/10/12.
//

import Foundation
import Firebase

struct PublishList {
    
    var author: [Author]
    
    var title: String
    
    var id: String
    
    var catagory: String
    
    var contents: String
    
    var createdTime: TimeInterval
}

struct Author {
    
    var email: String = "wayne@school.appworks.tw"
    
    var id: String = "waynechen323"
    
    var name: String = "AKA小安老師"
}
