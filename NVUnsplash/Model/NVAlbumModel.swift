//
//  NVAlbumModel.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

struct NVAlbumModel: Codable {
    var albumId: Int?
    var albumTitle: String?
    
    /**
     Initializes a new NVAlbumModel object with the provided information.
     
     - parameter id:        Represents Albums's unique id
     - parameter title:     Represents title of the album
    
     - Returns: Initialized NVAlbumModel object
     */
    init(id: Int, title: String) {
        self.albumId = id
        self.albumTitle = title
    }
}

extension NVAlbumModel: NVParseable {
    /**
     Responsible to parse the dictionary into NVAlbumModel object with the provided information.
     
     - parameter dictionary: Dictionary containing album related information
     
     - Returns: Result enum, success if parse completes successfully with new NVAlbumModel and error otherwise
     */
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<NVAlbumModel, NVError> {
        if let id = dictionary["id"] as? Int,
           let title = dictionary["title"] as? String {
            let albumObject = NVAlbumModel(id: id, title: title)
            return .success(albumObject)
        } else {
            return .failure(NVError.parser(string: "Unable to parse conversion rate"))
        }
    }
}

extension Array where Element == NVAlbumModel {
    /**
     Responsible to filter NVAlbumModel with matching album title.
     
     - parameter albumTitle: represents album title text needs to be matched
     
     - Returns: [NVAlbumModel], containing album title matches
     */
    
    func filterBy(_ albumTitle: String) -> [NVAlbumModel] {
        return filter {
            if let title = $0.albumTitle {
                return title.lowercased().contains(albumTitle.lowercased())
            }
            return false
        }
    }
}
