//
//  NVAlbumViewControllerDelegate.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 02/04/21.
//

import Foundation

protocol NVAlbumViewControllerDelegate: class {
    func fetchAlbumsDidSucceed()
    func fetchAlbumsDidFailedWith(_ error: NVError?)
}
