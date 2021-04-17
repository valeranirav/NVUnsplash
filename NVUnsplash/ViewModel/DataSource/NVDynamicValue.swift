//
//  NVDynamicValue.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

typealias CompletionHandler = (() -> Void)

/**
 `NVDynamicValue` is generic class which will be used to bind values from ViewModel to View

  It will execute a specific code overtime that a value has changed. We can also assume that our object can have multiple observers that are waiting for updates.
  To do so, This class is created keeping a dictionary of observers and their code (here a closure) that we want to execute when updated.
 */
class NVDynamicValue<T> {
    var value : T {
        didSet {
            self.notify()
        }
    }
    
///    Stores dictionary of observers that should be execute when value changed
    private var observers = [String: CompletionHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
///    Adds observer in dictionary with value as closure that can be executed when notified
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value() })
    }
    
    deinit {
        observers.removeAll()
    }
}
