//
//  NVPhotoViewModelTests.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import XCTest

@testable import NVUnsplash

class NVPhotoViewModelTests: XCTestCase {
    var subject : NVPhotoViewModel!
    var dataSource : NVGenericDataSource<NVPhotoModel>!
    private var serviceMock : NVPhotoServiceMock!
    private var vcMock : NVPhotoViewControllerMock!
    private var photoModelList: [NVPhotoModel]!
    
    override func setUpWithError() throws {
        self.photoModelList = [
            NVPhotoModel(albumId: 1, photoId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbUrl: "https://via.placeholder.com/150/92c952"),
            NVPhotoModel(albumId: 1, photoId: 2, title: "reprehenderit est deserunt velit ipsam", url: "https://via.placeholder.com/600/771796", thumbUrl: "https://via.placeholder.com/150/771796")
        ]
        
        self.serviceMock = NVPhotoServiceMock()
        serviceMock.photoModelList = photoModelList
        
        self.vcMock = NVPhotoViewControllerMock()
        self.dataSource = NVGenericDataSource<NVPhotoModel>()
        self.subject = NVPhotoViewModel(delegate: vcMock, service: serviceMock, dataSource: dataSource)
                
        dataSource.data.value = photoModelList
    }

    override func tearDownWithError() throws {
        self.dataSource = nil
        self.serviceMock = nil
        self.vcMock = nil
        self.subject = nil
    }
    
    func testFetchPhotoWithNoService() {
        // Not providing service to a view model. So expected to not be able to fetch Photos
        
        subject.service = nil
        subject.fetchPhotos(for: NVAlbumModel(id: 1, title: "Hello"))
        
        XCTAssertTrue(serviceMock.fetchPhotosCalled)
        
        XCTAssertTrue(vcMock.fetchPhotosDidFailedCalled)
        XCTAssertFalse(vcMock.fetchPhotosDidSucceedCalled)
    }
    
    func testFetchPhoto() {
        // Providing all data to a view model. So expected to be able to fetch Photos
        
        subject.fetchPhotos(for: NVAlbumModel(id: 1, title: "Hello"))
        
        XCTAssertTrue(serviceMock.fetchPhotosCalled)
        
        XCTAssertTrue(vcMock.fetchPhotosDidSucceedCalled)
        XCTAssertFalse(vcMock.fetchPhotosDidFailedCalled)
    }

    func testPhotoAtWhenIndexIsAvailable() {
        // Providing all data to a view model. So expected to be able to fetch Photos
        
        let photoModel = subject.photo(at: 0)
        XCTAssertNotNil(photoModel)
        XCTAssertEqual(photoModel?.albumId, 1)
        XCTAssertEqual(photoModel?.photoId, 1)
        XCTAssertEqual(photoModel?.photoTitle, "accusamus beatae ad facilis cum similique qui sunt")
        XCTAssertEqual(photoModel?.photoUrl, "https://via.placeholder.com/600/92c952")
        XCTAssertEqual(photoModel?.photoThumbUrl, "https://via.placeholder.com/150/92c952")
    }
    
    func testPhotoAtWhenIndexIsNotAvailable() {
        // Providing all data to a view model. So expected to be able to fetch Photos
                
        let photoModel = subject.photo(at: 4)
        XCTAssertNil(photoModel)        
    }
}
