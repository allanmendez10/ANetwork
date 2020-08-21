//
//  Repository.swift
//  ANetwork
//
//  Created by Allan Cordero Mendez on 8/3/20.
//

import Foundation


public class Repository: NSObject{
    
    private var session:URLSession?
    private var service:ManagerService?
    
    public init(url:String) {
        self.service = ManagerService.getInstance(url: url)
        self.session = URLSession.shared
    }
    
    
    public func executeMethodWithRequestObject<D:Decodable,E:Encodable>(path:String,method:HttpCode,object:E,onSuccess : @escaping (D) -> (),onError : @escaping (Error?) -> (), isMultipart : Bool = false){
        
        
        let request = service?.execute(path: path, httpMethod: method, object: object,isMultipart: isMultipart)
        
        self.session?.dataTask(with: request!) { (data, urlResponse, error) in
            
            if let error = error{
                onError(error)
            }else if let response = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let empData = try jsonDecoder.decode(D.self, from: response)
                    onSuccess(empData)
                    
                } catch  {
                    onError(nil)
                }
            }
            
        }.resume()
        
    }
    
    
    public func executeMethodWithoutRequestObject<D:Decodable>(path:String,method:HttpCode,onSuccess : @escaping (D) -> (),onError : @escaping (Error?) -> ()){
        
        let request = service?.execute(path: path, httpMethod: method)
        
        self.session?.dataTask(with: request!) { (data, urlResponse, error) in
            
            if let error = error{
                onError(error)
            }else if let response = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let empData = try jsonDecoder.decode(D.self, from: response)
                    onSuccess(empData)
                    
                } catch  {
                    onError(nil)
                }
            }
            
        }.resume()
        
    }
    
    
}
