//
//  NVPhotoViewControllerMock.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

@testable import NVUnsplash

class NVPhotoViewControllerMock: NVPhotoViewControllerDelegate {
    var fetchPhotosDidSucceedCalled = false
    var fetchPhotosDidFailedCalled = false
    
    func fetchPhotosDidSucceed() {
        fetchPhotosDidSucceedCalled = true
    }
    
    func fetchPhotosDidFailedWith(_ error: NVError?) {
        fetchPhotosDidFailedCalled = true
    }
}
