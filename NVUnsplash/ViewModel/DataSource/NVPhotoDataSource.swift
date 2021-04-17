//
//  NVPhotoDataSource.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation
import UIKit
/**
 `NVPhotoDataSource` acts as a dataSource for `NVPhotoViewController`
 
 It will implement the `UICollectionViewDataSource` methods
 This class allow us to saperate data layer from viewModel. So test case can be written even more accurately
*/
class NVPhotoDataSource : NVGenericDataSource<NVPhotoModel>, UICollectionViewDataSource {
    
//    MARK: UICollectionViewDataSource methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NVPhotoCellConstants.identifier, for: indexPath) as! NVPhotoCell
        let photoObject = self.data.value[indexPath.row]
        cell.photoObject = photoObject        
        return cell
    }
}

