//
//  NVAlbumServiceMock.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

@testable import NVUnsplash

class NVAlbumServiceMock: NVAlbumServiceProtocol {
    var albumModelList : [NVAlbumModel]?
    var fetchAlbumsCalled = false
    
    func fetchAlbums(_ completion: @escaping ((Result<[NVAlbumModel], NVError>) -> Void)) {
        fetchAlbumsCalled = true
        if let albumModelList = albumModelList {
            completion(.success(albumModelList))
        } else {
            completion(.failure(NVError.custom(string: "No converter")))
        }
    }
}
