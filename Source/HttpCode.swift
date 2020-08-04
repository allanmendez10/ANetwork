//
//  HttpCode.swift
//  ANetwork
//
//  Created by Allan Cordero Mendez on 8/3/20.
//

import Foundation

public enum HttpCode: CustomStringConvertible {
    case get
    case put
    case delete
    case post
    
    public var description: String {
        switch self {
        case .get:
            return "GET"
        case .delete:
            return "DELETE"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        
        }
    }
}
