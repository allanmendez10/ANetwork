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
    private let jsonEncoder:JSONEncoder?
    
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
        self.jsonEncoder = JSONEncoder()
        
    }
    
    func execute<E:Encodable>(path:String, httpMethod:HttpCode, object:E, isMultipart: Bool = false)->URLRequest! {
        var request = URLRequest(url: URL(string: self.sourcesURL! + path)!)
        request.httpMethod = httpMethod.description
        
        let httpRequestParams = try? self.jsonEncoder!.encode(object)
        
        if isMultipart {
            request =  postMultiPartdata(mirror: Mirror(reflecting: object), request: request)
        }
        else if let data = httpRequestParams{
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
        }
        
        return request
    }
    
    func execute(path:String, httpMethod:HttpCode, isMultipart: Bool = false)->URLRequest! {
        var request = URLRequest(url: URL(string: self.sourcesURL! + path)!)
        request.httpMethod = httpMethod.description
        return request
    }
    
    func postMultiPartdata(mirror: Mirror, request : URLRequest!) -> URLRequest!{
        
        var urlRequest = request
        let body = NSMutableData();
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        urlRequest!.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        for case let (label?, value) in mirror.children {
            
            if value is Data {
                
                let  TimeStamp = "\(Date().timeIntervalSince1970 * 1000).png"
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(label)\"; filename=\"\(TimeStamp)\"\r\n".data(using:.utf8)!)
                body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                body.append(value as! Data)
                body.append("\r\n".data(using: .utf8)!)
                
            }
            else
            {
                if let anEncoding = "--\(boundary)\r\n".data(using: .utf8) {
                    body.append(anEncoding)
                }
                if let anEncoding = "Content-Disposition: form-data; name=\"\(label)\"\r\n\r\n".data(using: .utf8) {
                    body.append(anEncoding)
                }
                
                body.append("\(value)".data(using: .utf8)!)
                
                if let anEncoding = "\r\n".data(using: .utf8) {
                    body.append(anEncoding)
                }
            }
        }
        
        if let anEncoding = "--\(boundary)--".data(using: .utf8) {
            body.append(anEncoding)
        }
  
        urlRequest!.httpBody = body as Data
        
        return urlRequest
        
    }
    
    
    
}


