//
//  ViewController.swift
//  ANetwork
//
//  Created by allanmendez10 on 08/03/2020.
//  Copyright (c) 2020 allanmendez10. All rights reserved.
//

import UIKit
import ANetwork


class ViewController: UIViewController {
    
    var repo : Repository?
    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repo = Repository(url:"https://jsonplaceholder.typicode.com/")
        getPost()
        //insertPost()
    }
    
    func getPosts(){
        
        self.repo!.executeGetMethod(path: "posts", method: HttpCode.get,
                                    onSuccess: {
                                        (posts:[Post]) in
                                        
                                        for post in posts{
                                            print("Title: \(post.title)")
                                        }
                                        
        }, onError: {
            error in
            print(error!.localizedDescription)
        })
    }
    
    func getPost(){
         
         self.repo!.executeGetMethod(path: "posts/1", method: HttpCode.get,
                                     onSuccess: {
                                         (post:Post) in
                                        DispatchQueue.main.async {
                                            // UI Update code here
                                        
                                        self.lblUserID.text = String(post.userId)
                                        
                                        self.lblId.text = String(post.id)
                                        
                                        self.lblBody.text = post.body
                                        
                                        self.lblTitle.text = post.title
                                        
                                        }
                                       
                                         
         }, onError: {
             error in
            self.lblError.isHidden = false
         })
     }
    
    func insertPost(){
        let newPost = Post(userId: 1,title: "ANetwork",body: "Body ANetwork")
        self.repo!.executeRequest(path: "posts", method: HttpCode.post,object:newPost,
                                  onSuccess: {
                                    (post:Post) in
                                    print("Title: \(post.title)")
                                    
                                    
        }, onError: {
            error in
            
            print(error!.localizedDescription)
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

