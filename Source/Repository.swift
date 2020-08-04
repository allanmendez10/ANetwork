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
    private let jsonEncoder:JSONEncoder?
    
    public init(url:String) {
        self.service = ManagerService.getInstance(url: url)
        self.session = URLSession.shared
        self.jsonEncoder = JSONEncoder()
    }
    
    
    public func executeRequest<D:Decodable,E:Encodable>(path:String,method:HttpCode,object:E?,onSuccess : @escaping (D) -> (),onError : @escaping (Error?) -> ()){
        
        let request = service?.execute(path: path, httpMethod: method,httpRequestParams:try? self.jsonEncoder!.encode(object))
        
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
    
    
    public func executeGetMethod<D:Decodable>(path:String,method:HttpCode,onSuccess : @escaping (D) -> (),onError : @escaping (Error?) -> ()){
        
      let request = service?.execute(path: path, httpMethod: method,httpRequestParams: nil)
        
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
