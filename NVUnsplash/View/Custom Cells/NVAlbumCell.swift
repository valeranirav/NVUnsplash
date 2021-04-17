//
//  NVAlbumCell.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import UIKit

struct NVAlbumCellConstants {
    static let identifier = "albumCell"
}

class NVAlbumCell: UITableViewCell {
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    var albumObject: NVAlbumModel? {
        didSet {
            guard let albumObject = albumObject else {
                return
            }
            
            albumTitleLabel.text = albumObject.albumTitle
        }
    }
}
