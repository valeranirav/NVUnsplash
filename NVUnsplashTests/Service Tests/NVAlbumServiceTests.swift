//
//  NVAlbumServiceTests.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import XCTest

@testable import NVUnsplash

class NVAlbumServiceTests: XCTestCase {

    var subject: NVAlbumService!
    
    override func setUpWithError() throws {
        subject = NVAlbumService()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testCancelRequest() {
        
        // giving a "previous" session
        subject.fetchAlbums{ _ in
             
        }
        
        // Expected to task nil after cancel
        subject.cancelFetchAlbums()
        XCTAssertNil(subject.task, "Expected task nil")
    }
}
