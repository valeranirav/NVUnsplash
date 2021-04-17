//
//  NVAlbumViewControllerMock.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

@testable import NVUnsplash

class NVAlbumViewControllerMock: NVAlbumViewControllerDelegate {
    var fetchAlbumsDidSucceedCalled = false
    var fetchAlbumsDidFailedCalled = false
    
    func fetchAlbumsDidSucceed() {
        fetchAlbumsDidSucceedCalled = true
    }
    
    func fetchAlbumsDidFailedWith(_ error: NVError?) {
        fetchAlbumsDidFailedCalled = true
    }
}
