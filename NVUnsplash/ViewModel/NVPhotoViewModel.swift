//
//  NVPhotoViewModel.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

protocol NVPhotoViewModelProtocol: class {
    func fetchPhotos(for album: NVAlbumModel?)
    func photo(at index:Int) -> NVPhotoModel?
}

/// `NVPhotoViewModel` will act as a viewModel for `NVPhotoViewController`

class NVPhotoViewModel: NVPhotoViewModelProtocol {
    weak var dataSource : NVGenericDataSource<NVPhotoModel>?
    weak var service: NVPhotoServiceProtocol?
    weak var photoVCDelegate: NVPhotoViewControllerDelegate?
    
    init(delegate: NVPhotoViewControllerDelegate?, service: NVPhotoServiceProtocol?, dataSource : NVGenericDataSource<NVPhotoModel>?) {
        self.photoVCDelegate = delegate
        self.service = service
        self.dataSource = dataSource
    }
    
    /**
     This method fetches photos and updating its dataSource once fetched
     
     Using `NVPhotoService` photos will fetched from server and once fetched, it will update the dataSource
     
     - parameter album: Album details for which photos needs to be fetched
     */
    
    func fetchPhotos(for album: NVAlbumModel?) {
        guard let service = service else {
            let error = NVError.custom(string: "Missing service")
            photoVCDelegate?.fetchPhotosDidFailedWith(error)
            return
        }
        
        service.fetchPhotos { [weak self] result in
            switch result {
            case .success(let photos) :
                // reload data
                self?.handleFetchPhotoSuccess(with: photos, for: album)
                
                break
            case .failure(let error) :
                self?.photoVCDelegate?.fetchPhotosDidFailedWith(error)
                
                break
            }
        }
    }
    
    /**
        Returns NVPhotoMedel from dataSource
     
        - parameter index: Index of object
     
        - returns: A *NVPhotoModel* object from specified index.
     */
    
    func photo(at index:Int) -> NVPhotoModel? {
        if let photoModels = self.dataSource?.data.value, index < photoModels.count {
            return self.dataSource?.data.value[index]
        }
        
        return nil
    }
}

//MARK:- Private Methods
extension NVPhotoViewModel {
    private func handleFetchPhotoSuccess(with photos: [NVPhotoModel], for album: NVAlbumModel?) {
        if let albumId = album?.albumId {
            self.dataSource?.data.value = photos.filterBy(albumId)
            photoVCDelegate?.fetchPhotosDidSucceed()
        }
    }
}
