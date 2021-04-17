//
//  NVPhotoService.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

/// Types adopting the `NVPhotoServiceProtocol` protocol can be used to fetch photos.

protocol NVPhotoServiceProtocol : class {
    
    /**
     Fetches photos
     
     - parameter completion: A closure to be executed once the photos are fetched.
     */
    func fetchPhotos(_ completion: @escaping ((Result<[NVPhotoModel], NVError>) -> Void))
}

final class NVPhotoService: NVRequestHandler, NVPhotoServiceProtocol {   
    var task : URLSessionTask?
    
    /**
        Responsible for fetching photos.
 
        - parameter completion: A closure to be executed once the request has finished.
    */
    
    func fetchPhotos(_ completion: @escaping ((Result<[NVPhotoModel], NVError>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchPhotos()
        
        let endpoint = "\(DataAPI.baseURL)/\(DataAPI.fetchPhotosEndPoint)"
        task = NVRequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    /// Responsible to cancel fetch photo task

    func cancelFetchPhotos() {        
        if let task = task {
            task.cancel()
            self.task = nil
        }
    }
}
