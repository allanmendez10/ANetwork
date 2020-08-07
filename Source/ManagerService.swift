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
    
    func execute(path:String, httpMethod:HttpCode, httpRequestParams:Data? = nil, postdatadictionary: [AnyHashable: Any]? = nil)->URLRequest! {
        var request = URLRequest(url: URL(string: self.sourcesURL! + path)!)
        request.httpMethod = httpMethod.description

        
        if let data = postdatadictionary{
           request =  postMultiPartdata(postdatadictionary: data, request: request)
        }
        else if let data = httpRequestParams{
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
        }
        
        return request
    }
    
    func postMultiPartdata( postdatadictionary: [AnyHashable: Any], request : URLRequest!) -> URLRequest!{
        
        var urlRequest = request
        let body = NSMutableData();
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        urlRequest!.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        for (key, value) in postdatadictionary {
            
            if(value is UIImage)
            {
                let  TimeStamp = "\(Date().timeIntervalSince1970 * 1000)"
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(TimeStamp)\"\r\n".data(using:.utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append((value as! UIImage).pngData()!)
                body.append(value as! Data)
                
            }
            else
            {
                if let anEncoding = "--\(boundary)\r\n".data(using: .utf8) {
                    body.append(anEncoding)
                }
                if let anEncoding = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) {
                    body.append(anEncoding)
                }
                if let aKey = postdatadictionary[key], let anEncoding = "\(aKey)".data(using: .utf8) {
                    body.append(anEncoding)
                }
                if let anEncoding = "\r\n".data(using: .utf8) {
                    body.append(anEncoding)
                }
            }
        }
        
        if let anEncoding = "--\(boundary)--\r\n".data(using: .utf8) {
            body.append(anEncoding)
        }
        // setting the body of the post to the reqeust
        urlRequest!.httpBody = body as Data

        return urlRequest
        
    }
    
}
