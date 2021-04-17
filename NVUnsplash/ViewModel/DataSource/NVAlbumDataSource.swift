//
//  NVAlbumDataSource.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation
import UIKit
/**
 `NVAlbumDataSource` acts as a dataSource for `NVAlbumViewController`
 
 It will implement the `UITableViewDataSource` methods
 This class allow us to saperate data layer from viewModel. So test case can be written even more accurately
*/
class NVAlbumDataSource : NVGenericDataSource<NVAlbumModel>, UITableViewDataSource {
    
//    MARK: UICollectionViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NVAlbumCellConstants.identifier, for: indexPath) as! NVAlbumCell
        let albumObject = self.data.value[indexPath.row]
        cell.albumObject = albumObject
        return cell
    }    
}

