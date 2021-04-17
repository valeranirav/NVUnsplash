//
//  NVPhotoServiceMock.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

@testable import NVUnsplash

class NVPhotoServiceMock: NVPhotoServiceProtocol {
    var photoModelList: [NVPhotoModel]?
    var fetchPhotosCalled = true
    
    func fetchPhotos(_ completion: @escaping ((Result<[NVPhotoModel], NVError>) -> Void)) {
        if let photoModelList = photoModelList {
            completion(.success(photoModelList))
        } else {
            completion(.failure(NVError.custom(string: "No converter")))
        }
    }
}
