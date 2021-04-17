//
//  NVPhotoViewModelMock.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

@testable import NVUnsplash

class NVPhotoViewModelMock: NVPhotoViewModelProtocol {
    var photoModelList: [NVPhotoModel]?
    var fetchPhotosCalled = false
    var fetchPhotoAtCalled = false
    
    func fetchPhotos(for album: NVAlbumModel?) {
        fetchPhotosCalled = true
    }
        
    func photo(at index:Int) -> NVPhotoModel? {
        fetchPhotoAtCalled = true
        return photoModelList?[index]
    }
}
