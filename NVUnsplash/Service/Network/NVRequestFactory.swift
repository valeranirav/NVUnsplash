//
//  NVRequestFactory.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

/// `NVRequestFactory` creates a request based on the information passed

final class NVRequestFactory {
    
    /// `Method` is the method type returned by app.
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    /**
     Responsible for creating URLRequest
 
     - parameter method: Represents method type for request
     - parameter url:    Represents URL for request
     
     - Returns: URLRequest object
    */
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
