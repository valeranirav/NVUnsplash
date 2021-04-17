//
//  NVAlbumViewModelTests.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import XCTest

@testable import NVUnsplash

class NVAlbumViewModelTests: XCTestCase {
    var subject : NVAlbumViewModel!
    var dataSource : NVGenericDataSource<NVAlbumModel>!
    private var serviceMock : NVAlbumServiceMock!
    private var vcMock : NVAlbumViewControllerMock!
    private var albumModelList: [NVAlbumModel]!
    
    override func setUpWithError() throws {
        self.albumModelList = [
            NVAlbumModel(id: 1, title: "quidem molestiae enim"),
            NVAlbumModel(id: 2, title: "sunt qui excepturi placeat culpa")
        ]
        
        self.serviceMock = NVAlbumServiceMock()
        serviceMock.albumModelList = albumModelList
        
        self.vcMock = NVAlbumViewControllerMock()
        self.dataSource = NVGenericDataSource<NVAlbumModel>()
        self.subject = NVAlbumViewModel(delegate: vcMock, service: serviceMock, dataSource: dataSource)
                
        dataSource.data.value = albumModelList
    }

    override func tearDownWithError() throws {
        self.dataSource = nil
        self.serviceMock = nil
        self.vcMock = nil
        self.subject = nil
    }
    
    func testFetchAlbumWithNoService() {
        // Not providing service to a view model. So expected to not be able to fetch Albums
        
        subject.service = nil
        subject.fetchAlbums()
        
        XCTAssertFalse(serviceMock.fetchAlbumsCalled)
        
        XCTAssertTrue(vcMock.fetchAlbumsDidFailedCalled)
        XCTAssertFalse(vcMock.fetchAlbumsDidSucceedCalled)
    }
    
    func testFetchAlbum() {
        // Providing all data to a view model. So expected to be able to fetch Albums
        
        subject.fetchAlbums()
        
        XCTAssertTrue(serviceMock.fetchAlbumsCalled)
        
        XCTAssertTrue(vcMock.fetchAlbumsDidSucceedCalled)
        XCTAssertFalse(vcMock.fetchAlbumsDidFailedCalled)
        
        XCTAssertEqual(dataSource?.data.value.count, 2)
    }

    func testFetchAlbumWhenMatchingSerachText() {
        // Providing all data to a view model. So expected to be able to fetch Albums
        subject.allAlbums = albumModelList
        subject.fetchAlbums(with: "sunt")
        
        XCTAssertFalse(serviceMock.fetchAlbumsCalled)
        
        XCTAssertTrue(vcMock.fetchAlbumsDidSucceedCalled)
        XCTAssertFalse(vcMock.fetchAlbumsDidFailedCalled)
        
        XCTAssertEqual(dataSource?.data.value.count, 1)
    }
    
    func testAlbumAtWhenIndexIsAvailable() {
        // Providing all data to a view model. So expected to be able to fetch Albums
        
        let albumModel = subject.album(at: 0)
        XCTAssertNotNil(albumModel)
        XCTAssertEqual(albumModel?.albumId, 1)
        XCTAssertEqual(albumModel?.albumTitle, "quidem molestiae enim")
    }
    
    func testAlbumAtWhenIndexIsNotAvailable() {
        // Providing all data to a view model. So expected to be able to fetch Albums
                
        let albumModel = subject.album(at: 3)
        XCTAssertNil(albumModel)
    }
}
