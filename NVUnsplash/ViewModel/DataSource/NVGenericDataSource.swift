//
//  NVGenericDataSource.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

/// `NVGenericDataSource` is generic class which will provide functionality of separating ViewModel to the data layer. This class can be reused regardless the data we would like to update

class NVGenericDataSource<T>: NSObject {
    var data: NVDynamicValue<[T]> = NVDynamicValue([])
}
