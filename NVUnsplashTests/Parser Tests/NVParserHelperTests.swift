//
//  NVParserHelperTests.swift
//  NVUnsplashTests
//
//  Created by Nirav Valera on 02/04/21.
//

import XCTest

@testable import NVUnsplash

class NVParserHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseEmptyPhoto() {
        
        // Providing empty data
        let data = Data()
        
        // Providing completion after parsing
        // Expected valid NVPhotoModel with valid data
        let completion : ((Result<[NVPhotoModel], NVError>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        
        NVParserHelper.parse(data: data, completion: completion)
    }
    
    func testParsePhoto() {
        
        // Providing a sample json file
        guard let data = FileManager.readJson(forResource: "photo_mock") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }
        
        // Providing completion after parsing
        // Expected valid NVPhotoModel with valid data
        let completion : ((Result<[NVPhotoModel], NVError>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid NVPhotoModel")
            case .success(let photoModelList):
                
                let photoModel = photoModelList[0]
                
                XCTAssertEqual(photoModel.photoId, 1, "Expected 1 as Photo Id")
                XCTAssertEqual(photoModel.photoTitle, "accusamus beatae ad facilis cum similique qui sunt", "Expected accusamus beatae ad facilis cum similique qui sunt as Photo Title")
                XCTAssertEqual(photoModel.photoUrl, "https://via.placeholder.com/600/92c952", "Expected https://via.placeholder.com/600/92c952 as Photo url")
                XCTAssertEqual(photoModel.photoThumbUrl, "https://via.placeholder.com/150/92c952", "Expected https://via.placeholder.com/150/92c952 as Photo thumbnail url")
                XCTAssertEqual(photoModelList.count, 2, "Expected 2 photos")
            }
        }
        
        NVParserHelper.parse(data: data, completion: completion)
    }
    
    func testWrongKeyPhoto() {
        
        // Providing a wrong dictionary
        let dictionary = ["test" : 123 as AnyObject]
        
        // Expected to return error of NVPhotoModel
        let result = NVPhotoModel.parseObject(dictionary: dictionary)
        
        switch result {
        case .success(_):
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}

extension FileManager {
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle(for: NVParserHelperTests.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}
