//
//  NVRequestService.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

/// `NVRequestService` is a concrete service class for requesting data from the server

final class NVRequestService {
    
    /**
     Creates an `URLSessionTask` with the specified url string and session.
     
     - parameter urlString:   URL that will be used to create request
     - parameter session:     URLSession which will be used to create URLDataTask
     - parameter completion:  A closure to be executed once the task finishes. This closure has no return value and takes one argument: the server response as NVResult enum
     
     - Returns: URLSessionTask object
     */
    
    func loadData(
        urlString: String,
        session: URLSession = URLSession(configuration: .default),
        completion: @escaping (Result<Data, NVError>) -> Void
    ) -> URLSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Invalid url")))
            return nil
        }
        
        var request = NVRequestFactory.request(method: .GET, url: url)
        
        if let reachability = Reachability(), !reachability.isReachable {
            request.cachePolicy = .returnCacheDataDontLoad
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
