//
//  NVPhotoViewControllerDelegate.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

protocol NVPhotoViewControllerDelegate: class {
    func fetchPhotosDidSucceed()
    func fetchPhotosDidFailedWith(_ error: NVError?)
}
