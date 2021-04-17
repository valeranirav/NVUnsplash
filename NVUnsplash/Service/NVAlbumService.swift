//
//  NVAlbumService.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

/// Types adopting the `NVAlbumServiceProtocol` protocol can be used to fetch albums.

protocol NVAlbumServiceProtocol : class {
    
    /**
     Fetches photos
     
     - parameter completion: A closure to be executed once the albums are fetched.
     */
    func fetchAlbums(_ completion: @escaping ((Result<[NVAlbumModel], NVError>) -> Void))
}

final class NVAlbumService: NVRequestHandler, NVAlbumServiceProtocol {
    var task : URLSessionTask?
    
    /**
        Responsible for fetching albums.
 
        - parameter completion: A closure to be executed once the request has finished.
    */
    
    func fetchAlbums(_ completion: @escaping ((Result<[NVAlbumModel], NVError>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchAlbums()
        
        let endpoint = "\(DataAPI.baseURL)/\(DataAPI.fetchAlbumsEndPoint)"
        task = NVRequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    /// Responsible to cancel fetch album task

    func cancelFetchAlbums() {
        if let task = task {
            task.cancel()
            self.task = nil
        }
    }
}
