//
//  NVPhotoCellCollectionViewCell.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Kingfisher
import UIKit

struct NVPhotoCellConstants {
    static let identifier = "photoCell"
}

class NVPhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImgView: UIImageView!
    
    var photoObject:NVPhotoModel? {
        didSet {
            guard let photoObject = photoObject else {
                return
            }
            
            configureImageWith(photoObject.photoThumbUrl)
        }
    }
    
//    MARK: LifeCyclev Method
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background color
        self.photoImgView.backgroundColor = UIColor.lightGray
    }
}

//MARK: - Geenral Methods
extension NVPhotoCell {
    func configureImageWith(_ photoThumbUrlString: String?) {
        if let thumbUrlStr = photoThumbUrlString, let thumbUrl = URL(string:thumbUrlStr) {
            photoImgView.kf.setImage(with: thumbUrl, placeholder: nil, options: nil) { _ in
                UIView.animate(withDuration: 2, animations: { [weak self] in
                    self?.photoImgView.alpha = 1
                })
            }            
        }
    }
}
