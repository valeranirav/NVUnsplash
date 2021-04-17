//
//  NVAlertController.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//


import Foundation
import UIKit

extension UIAlertController {
    
    /**
     Display an Alert / Actionsheet
     
     - parameter controller:     Object of controller on which you need to display Alert/Actionsheet
     - parameter strMessage:    Message to display in Alert / Actionsheet
     - parameter style:          AlertController Style .Alert / .Actionshhet
     - parameter cancelBtn:     Cancel button title
     - parameter distrutiveBtn: Distructive button title
     - parameter otherButtonArr: Array of other button title
     - parameter completion:     Completion closure. Other Button Index Starting From - 0 | Destructive Index - (Last / 2nd Last Index) | Cancel Index - (Last / 2nd Last Index)
     */
    class func showAlert(controller : AnyObject ,
                         strMessage :String? ,
                         style : UIAlertController.Style ,
                         cancelBtn :String? = nil,
                         distrutiveBtn : String? = nil,
                         otherButtonArr : Array<String>? = nil,
                         completion : ((Int, String) -> Void)?) -> Void {
        
        let strTitle = "NVPhotoDemo"
        
        let alert = UIAlertController.init(title: strTitle, message: strMessage, preferredStyle: style)
        
        if let strDistrutiveBtn = distrutiveBtn {
            let aStrDistrutiveBtn = strDistrutiveBtn
            alert.addAction(UIAlertAction.init(title: aStrDistrutiveBtn, style: .destructive, handler: { _ in
                completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strDistrutiveBtn)
            }))
        }
        
        if let strCancelBtn = cancelBtn {
            let aStrCancelBtn = strCancelBtn
            alert.addAction(UIAlertAction.init(title: aStrCancelBtn, style: .default, handler: { _ in
                if distrutiveBtn != nil {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count + 1 : 1, strCancelBtn)
                } else {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strCancelBtn)
                }
            }))
        }
        
        if let arr = otherButtonArr {
            for (index, value) in arr.enumerated() {
                let aValue = value
                alert.addAction(UIAlertAction.init(title: aValue, style: .default, handler: { _ in
                    completion?(index, value)
                }))
            }
        }
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    
    /**
     Display an Alert With "OK" Button
     
     - parameter controller:  Object of controller on which you need to display Alert
     - parameter strMessage: Message to display in Alert
     - parameter completion:  Completion block. Ok Index - 0
     */
    class func showAlertWithOkButton(controller : AnyObject ,
                                     strMessage :String? ,
                                     completion : ((Int, String) -> Void)?) -> Void {
        
        self.showAlert(controller: controller, strMessage: strMessage, style: .alert, otherButtonArr: ["OK"], completion: completion)
    }
}

