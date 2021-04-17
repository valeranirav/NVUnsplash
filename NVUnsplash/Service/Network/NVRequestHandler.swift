//
//  NVRequestHandler.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

/// `NVRequestHandler` handles the result of the request

class NVRequestHandler {
    
    /**
        Handles the response data of the request
     
        - parameter completion: The closure called when the `Data` parsing using `NVParserHelper` is completed
     
        - returns: A closure which takes one argument: NVResult enum
    */
    func networkResult<T: NVParseable> (completion: @escaping ((Result<[T], NVError>) -> Void)) -> ((Result<Data, NVError>) -> Void) {
        return { dataResult in
            DispatchQueue.global(qos: .background).async(execute: {
                switch dataResult {
                case .success(let data) :
                    NVParserHelper.parse(data: data, completion: completion)
                    break
                case .failure(let error) :
                    print("Network error \(error)")
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    break
                }
            })
        }
    }
}
