//
//  NVAlbumViewModel.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

protocol NVAlbumViewModelProtocol: class {
    func fetchAlbums(with albumTitle: String?)
    func album(at index:Int) -> NVAlbumModel?
}

/// `NVAlbumViewModel` will act as a viewModel for `NVAlbumViewController`

class NVAlbumViewModel: NVAlbumViewModelProtocol {
    weak var dataSource : NVGenericDataSource<NVAlbumModel>?
    weak var service: NVAlbumServiceProtocol?
    weak var albumVCDelegate: NVAlbumViewControllerDelegate?
    var allAlbums: [NVAlbumModel]?
    
    init(delegate: NVAlbumViewControllerDelegate?, service: NVAlbumServiceProtocol?, dataSource : NVGenericDataSource<NVAlbumModel>?) {
        self.albumVCDelegate = delegate
        self.service = service
        self.dataSource = dataSource
    }
    
    /**
     This method fetches albums and updating its dataSource once fetched
     
     Using `NVAlbumService` albums will fetched from server and once fetched  if not available locally and then it will update the dataSource
     
     - parameter albumTitle: represents album title
     */
    
    func fetchAlbums(with albumTitle: String?) {
        if let allAlbums = allAlbums, !allAlbums.isEmpty {
            var albums = allAlbums
            if let albumTitle = albumTitle, !albumTitle.isEmpty {
                albums = allAlbums.filterBy(albumTitle)
            }
            self.dataSource?.data.value = albums
            albumVCDelegate?.fetchAlbumsDidSucceed()
        } else {
            fetchAlbums()
        }
    }
    
    /**
        Returns NVAlbumMedel from dataSource
     
        - parameter index: Index of object
     
        - returns: A *NVAlbumModel* object from specified index.
     */
    
    func album(at index:Int) -> NVAlbumModel? {
        if let albumModels = self.dataSource?.data.value, index < albumModels.count {
            return self.dataSource?.data.value[index]
        }
        
        return nil
    }
}

//MARK:- Private methods
extension NVAlbumViewModel {
    func fetchAlbums() {
        guard let service = service else {
            let error = NVError.custom(string: "Missing service")
            albumVCDelegate?.fetchAlbumsDidFailedWith(error)
            return
        }
        
        service.fetchAlbums { [weak self] result in
            switch result {
            case .success(let albums) :
                // reload data
                self?.handleFectchAlbumSuccess(with: albums)
                
                break
                
            case .failure(let error) :
                self?.albumVCDelegate?.fetchAlbumsDidFailedWith(error)
                break
            }            
        }
    }
    
    func handleFectchAlbumSuccess(with albums: [NVAlbumModel]) {
        self.allAlbums = albums
        self.dataSource?.data.value = albums
        albumVCDelegate?.fetchAlbumsDidSucceed()
    }
}
