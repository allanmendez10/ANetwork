//
//  ManagerService.swift
//  ANetwork
//
//  Created by Allan Cordero Mendez on 8/3/20.
//

import UIKit


class ManagerService: NSObject {
    
    private var sourcesURL:String?
    static var instance: ManagerService?
    
    
    static func getInstance(url:String)->ManagerService?{
        
        if let inst = self.instance{
            return inst
        }else{
            self.instance = ManagerService(url: url)
        }
        
        return self.instance
    }
    
    
    init(url:String) {
        self.sourcesURL =  url
    }
    
    func execute(path:String, httpMethod:HttpCode, httpRequestParams:Data? )->URLRequest! {
        var request = URLRequest(url: URL(string: self.sourcesURL! + path)!)
        request.httpMethod = httpMethod.description
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let data = httpRequestParams{
            request.httpBody = data
        }
        
        return request
    }
    
    
}
