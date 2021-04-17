//
//  NVPhotoModel.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

struct NVPhotoModel: Codable {
    var albumId: Int?
    var photoId: Int?
    var photoTitle: String?
    var photoUrl: String?
    var photoThumbUrl: String?
    
    /**
     Initializes a new NVPhotoModel object with the provided information.
     
     - parameter albumId:   Represents Album's unique id
     - parameter photoId:   Represents Photo's unique id
     - parameter title:     Represents title of the photo
     - parameter url:       Represents URL from where photo should be downloaded
     - parameter thumbUrl:  Represents URL from where thumbnail of photo should be download
     
     - Returns: Initialized NVPhotoModel object
     */
    init(albumId: Int, photoId: Int, title: String, url: String, thumbUrl: String) {
        self.albumId = albumId
        self.photoId = photoId
        self.photoTitle = title
        self.photoUrl = url
        self.photoThumbUrl = thumbUrl
    }
}

extension NVPhotoModel : NVParseable {
    /**
     Responsible to parse the dictionary into NVPhotoModel object with the provided information.
     
     - parameter dictionary: Dictionary containing photo related information
     
     - Returns: NVResult enum, success if parse completes successfully with new NVPhotoModel and error otherwise
     */
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<NVPhotoModel, NVError> {
        if let albumId = dictionary["albumId"] as? Int,
           let photoId = dictionary["id"] as? Int,
           let title = dictionary["title"] as? String,
           let url = dictionary["url"] as? String,
           let thumbUrl = dictionary["thumbnailUrl"] as? String {
            
            let photoObject:NVPhotoModel = NVPhotoModel(
                albumId: albumId,
                photoId: photoId,
                title: title,
                url: url,
                thumbUrl: thumbUrl
            )
            
            return .success(photoObject)
        } else {
            return .failure(NVError.parser(string: "Unable to parse conversion rate"))
        }
    }
}

extension Array where Element == NVPhotoModel {
    /**
     Responsible to filter NVPhotoModel for matching album id.
     
     - parameter albumId: represents album's unique id needs to be matched
     
     - Returns: Array of NVPhotoModel where NVPhotoModel contains specified album id
     */
    
    func filterBy(_ albumId: Int) -> [NVPhotoModel] {
        return filter { $0.albumId == albumId }
    }
}
