//
//  NVParserHelper.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import Foundation

/// Types adopting the `NVParceable` protocol can be used to parse the data and map it to Model class/layer.

protocol NVParseable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, NVError>
}

/// `NVParserHelper` class responsible for parsing data and map it to the model layer

final class NVParserHelper {
    
    /**
        Static function that parse Data into JSON and then into meaningful Model object
     
        - parameter data:        `Data` downloaded from server
        - parameter completion:  A closure to be executed once the parsing Data finishes. This closure has no return value and takes one argument: response as Result enum
    */
    
    static func parse<T: NVParseable>(data: Data, completion : (Result<[T], NVError>) -> Void) {    
        do {
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                
                // init final result
                var finalResult : [T] = []
                
                
                for object in result {
                    if let dictionary = object as? [String : AnyObject] {
                        
                        // check foreach dictionary if parceable
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(_):
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel)
                            break
                        }
                    }
                }
                
                completion(.success(finalResult))
                
            } else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
