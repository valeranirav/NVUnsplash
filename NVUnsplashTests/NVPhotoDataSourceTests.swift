//
//  NVPhotoDataSourceTests.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import XCTest

@testable import NVUnsplash

class NVPhotoDataSourceTests: XCTestCase {
    var subject: NVPhotoDataSource!
    var collectionView: UICollectionView!

    override func setUpWithError() throws {        
        subject = NVPhotoDataSource()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let size = CGRect(x: 0, y: 0, width: 100, height: 100)
        collectionView = UICollectionView(frame: size, collectionViewLayout: layout)
    }

    override func tearDownWithError() throws {
        subject = nil
        collectionView = nil
    }

    func testEmptyValueInDataSource() {
        
        // giving empty data value
        subject.data.value = []
        collectionView.dataSource = subject
        
        // Expected one section
        XCTAssertEqual(subject.numberOfSections(in: collectionView), 1, "Expected one section in collection view")
        
        // Expected zero cells
        XCTAssertEqual(subject.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in collection view")
    }

    func testValueInDataSource() {
        
        // Providing data value
        subject.data.value = [
            NVPhotoModel(albumId: 1, photoId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbUrl: "https://via.placeholder.com/150/92c952"),
            NVPhotoModel(albumId: 1, photoId: 2, title: "reprehenderit est deserunt velit ipsam", url: "https://via.placeholder.com/600/771796", thumbUrl: "https://via.placeholder.com/150/771796")
        ]
        collectionView.dataSource = subject

        // Expected one section
        XCTAssertEqual(subject.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        
        // Expected zero cells
        XCTAssertEqual(subject.collectionView(collectionView, numberOfItemsInSection: 0), 2, "Expected two cell in table view")
    }
}
