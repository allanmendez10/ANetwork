//
//  Post.swift
//  ANetwork_Example
//
//  Created by Allan Cordero Mendez on 8/3/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct Post : Codable {
    
     let userId:Int
     let id: Int
     let title: String
     let body:String
     
    
    init(userId:Int, id:Int, title:String, body:String) {
        self.userId =  userId
        self.id =  id
        self.title = title
        self.body = body
    }
    
    init(userId:Int, title:String, body:String) {
        
        self.userId =  userId
         self.title = title
         self.body = body
        self.id = 0
     }
    
 
}
