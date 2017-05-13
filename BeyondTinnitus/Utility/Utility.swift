//
//  Utility.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2016. 11. 22..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let backgroundTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(backgroundTapGesture)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

struct Utility {
    static func alert(message: String, vc: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Whoops...", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: handler))
        vc.present(alert, animated: true, completion: nil)
    }
}
