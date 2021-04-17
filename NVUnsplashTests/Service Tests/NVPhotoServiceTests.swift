//
//  NVPhotoServiceTests.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import XCTest

@testable import NVUnsplash

class NVPhotoServiceTests: XCTestCase {
    var subject: NVPhotoService!
    
    override func setUpWithError() throws {
        subject = NVPhotoService()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testCancelRequest() {
        
        // giving a "previous" session
        subject.fetchPhotos{ _ in
             
        }
        
        // Expected to task nil after cancel
        subject.cancelFetchPhotos()
        XCTAssertNil(subject.task, "Expected task nil")
    }
}
