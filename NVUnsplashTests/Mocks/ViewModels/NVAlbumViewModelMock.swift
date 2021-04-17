//
//  NVAlbumViewModelMock.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

@testable import NVUnsplash

class NVAlbumViewModelMock: NVAlbumViewModelProtocol {
    var albumModelList: [NVAlbumModel]?
    var fetchAlbumsCalled = false
    var fetchAlbumAtCalled = false
    
    func fetchAlbums(with albumTitle: String?) {
        fetchAlbumsCalled = true
    }
    
    func album(at index:Int) -> NVAlbumModel? {
        fetchAlbumAtCalled = true
        return albumModelList?[index]
    }    
}
